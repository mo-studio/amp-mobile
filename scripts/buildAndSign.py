#!/usr/bin/env python3
import iosJobUtil, subprocess, sys, os, json, atexit, base64, uuid, shutil, argparse, importKeys, tempfile, validateAndUpload

# Directory where build provisioning profiles reside
BUILD_PROFILES_DIR = os.path.expanduser('~') + '/Library/MobileDevice/Provisioning Profiles/'

def deleteKeyChain(keychainName):
    os.system(f'security -v delete-keychain {keychainName}')

def cleanupProvisioning(fileNames):
    for file in fileNames:
        if os.path.exists(file): os.remove(file)

# Main
parser = argparse.ArgumentParser(description='Build and sign an ipa.')
parser.add_argument('configFile', help='pipeline config file')
parser.add_argument('configuration', help='pipeline config file')
parser.add_argument('plistSelector', help='must match key in "plist" object of .pipeline.json')
parser.add_argument('b64Certs', help='Path to base64 encoded p12 file')
parser.add_argument("--bitCodeOff", help="increase output verbosity", action='store_true')

args = parser.parse_args()

uid = str(uuid.uuid1())
importKeys.importSignKeys(args.b64Certs, uid)
# delete keychain after process is done
atexit.register(deleteKeyChain, uid)

# Load config from config file
scheme = ''
buildPlist = ''
buildType = args.plistSelector
mobileProvisionDir=''

with open(args.configFile) as config_file:
    config = json.load(config_file)
    scheme = config['scheme']
    buildPlistPath = config['plists'][buildType]
    mobileProvisionDir = config['mobileProvisionDir']
    packageName = config['projectOrWorkspaceName']
# base64 decode and place both .mobileprovision file
mobileProvisionFiles = []
for file in os.listdir(mobileProvisionDir):
    targetFileName = f'{BUILD_PROFILES_DIR}{os.getpid()}_{uuid.uuid4()}.mobileprovision'
    shutil.copyfile(mobileProvisionDir + '/' + file, targetFileName)
    mobileProvisionFiles.append(targetFileName)

# Register exit handler that will clean up .mobileprovision files on exit
atexit.register(cleanupProvisioning, mobileProvisionFiles)

# Determine package type
isWorkspace = packageName.endswith('xcworkspace')
packageFlag = ''
if isWorkspace:
    packageFlag = '-workspace'
else:
    packageFlag = '-project'

projectName = os.path.splitext(packageName)[0]

# Start WFA Edit

# Build Flutter release
projectRoot = os.path.abspath(os.path.join(os.curdir, os.pardir))
commandStr = projectRoot + '/amp/scripts/flutter_with_env.bash build ios --obfuscate --split-debug-info=debug_ios'
print(commandStr)
result = subprocess.run(commandStr, shell=True)
if result.returncode != 0:
    exit(1)


# End WFA Edit

## In two commandStr below, had to add 'cd ios;' at start. 

# Create archive dir
bitCodeString = ''
#get configuration name
configuration = args.configuration
if args.bitCodeOff:
    bitCodeString = 'ENABLE_BITCODE=NO'

# create temp dir to subtitute for DerivedData folder to avoid caching issues
with tempfile.TemporaryDirectory() as tmpdirname:
    commandStr = f'cd ios; xcodebuild -quiet {packageFlag} {packageName} -scheme {scheme} -sdk iphoneos -configuration {configuration} archive -archivePath {buildType}/{projectName}.xcarchive {bitCodeString} -derivedDataPath {tmpdirname}'
    print(commandStr)
    result = subprocess.run(commandStr, shell=True)
    if result.returncode != 0:
        exit(1)
    # Export archive dir to .ipa
    commandStr = f'cd ios; xcodebuild -quiet -exportArchive -archivePath {buildType}/{projectName}.xcarchive -exportOptionsPlist {buildPlistPath} -exportPath {buildType} -allowProvisioningUpdates'
    print(commandStr)
    result = subprocess.run(commandStr, shell=True)
    if result.returncode != 0:
        exit(1)
