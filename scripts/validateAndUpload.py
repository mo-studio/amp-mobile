#!/usr/bin/env python3

import subprocess, sys, os, atexit, argparse, json

def upload(archive, username, pwd):
    archiveName = archive.replace(' ', '_')
    print(f'archive: {archiveName}, username: {username}')
    commandStr = f'xcrun altool --upload-app -f {archiveName} -t ios -u \'{username}\' -p {pwd}'
    # TODO remove after testing
    print(f'Uploading binary to store - using command: {commandStr}')
    result = subprocess.run(commandStr, shell=True)
    if result.returncode != 0:
        print("Failed to validate archive before uploading to app store!")
        exit(1)
    else:
        print("Successfully uploaded archive to app store!")

if __name__ == '__main__':
    # parse command line arguments
    parser = argparse.ArgumentParser(description='Deliver ipa.')
    parser.add_argument('configFile', help='pipeline config file')
    parser.add_argument('buildType', help='pipeline config file')
    parser.add_argument('appStoreUser', help='App store username to upload binary file')
    parser.add_argument('oneTimeAppPassword', help='App store application one time password used to upload binary file')
    args = parser.parse_args()
    username = args.appStoreUser
    pwd = args.oneTimeAppPassword
    buildDir = args.buildType

    with open(args.configFile) as config_file:
        #open .pipeline.json file and get configuration information
        config = json.load(config_file)
        # Use scheme name as default ipa name, use specified name if present
        ipaName = f'{config["scheme"]}.ipa'
        if 'ipaName' in config:
            ipaName = config['ipaName'][args.buildType]
        ipaPath = os.path.join(buildDir,ipaName)
        print(f'Uploading ipa at {ipaPath}')
        upload(ipaPath, username, pwd)

