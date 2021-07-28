#!/usr/bin/env python3
import os, re, subprocess, json

# Returns the xcode package name for the package in dir
# Only looks for .xcworkspace since that's what the Flutter directions use to build the archive
def extractProjWorkspaceName(dir):
    packageCandidates = [f for f in os.listdir(dir) if re.match(r'.*xcworkspace', f)]
    if packageCandidates == []:
        print('No XCode packages found. I\'m looking for directories ending in .xcodeproj or .xcworkspace.')
        return ''
    elif len(packageCandidates) == 1:
        return packageCandidates[0]
    else:
        print('Too many project candidates: ')
        print(packageCandidates)
        return ''

# Returns list of schemes in packageName
def getSchemes(packageName, isWorkspace):
    getSchemesArgArray = ['xcodebuild', '-json', '-list']
    if isWorkspace:
        getSchemesArgArray += ['-workspace', packageName]
        schemesKey = 'workspace'
    else:
        getSchemesArgArray += ['-project', packageName]
        schemesKey = 'project'
    result = subprocess.run(getSchemesArgArray, stdout=subprocess.PIPE)
    projInfo = json.loads(result.stdout)
    return projInfo[schemesKey]['schemes']
