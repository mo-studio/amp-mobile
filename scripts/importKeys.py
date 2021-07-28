#!/usr/bin/env python3
import os, sys, subprocess

def importSignKeys(p12Path,  tmpKeychainName):
    TMP_CERT_NAME = './tmpCert.p12'
    # Don't worry. This doesn't actually protect anything
    DUMMY_PASSWORD= 'dummyPassword'

    # Decode Cert file
    os.system('base64 --decode -i %s -o %s' % (p12Path, TMP_CERT_NAME))
    #tmpKeychainName = sys.argv[2]
    # Enumerate and parse existing keychains
    result=subprocess.run(['security', '-v', 'list-keychains', '-d', 'user'], capture_output=True)
    lines=result.stdout.decode('utf-8').splitlines()
    keychains = []
    for keychain in lines:
        # Strip leading white space, remove leading and trailing quotes, then take basename of path
        keychains.append(os.path.basename(keychain.lstrip()[1:-1]))

    # Create new keychain for our keys
    os.system('security -v create-keychain -p %s %s' % (DUMMY_PASSWORD, tmpKeychainName))

    # Add our keychain to the front of search list
    os.system('security -v list-keychains -s %s %s' % (tmpKeychainName, ' '.join(keychains)))

    # Configure keychain to have 1hr lockout time
    os.system('security -v set-keychain-settings -t %i %s' % (3600, tmpKeychainName))

    # Unlock the keychain so keys can be accessed by the build system
    os.system('security -v unlock-keychain -p %s %s' % (DUMMY_PASSWORD, tmpKeychainName))

    # Import cert and private key into keychain
    os.system('security -v import %s -P "" -T /usr/bin/codesign  -k %s' % (TMP_CERT_NAME, tmpKeychainName))

    # Hack around bug where allowed apps list is ignored
    # https://stackoverflow.com/questions/39868578/security-codesign-in-sierra-keychain-ignores-access-control-settings-and-ui-p
    os.system('security -v set-key-partition-list -S apple-tool:,apple: -s -k %s %s 1> /dev/null' % (DUMMY_PASSWORD, tmpKeychainName))