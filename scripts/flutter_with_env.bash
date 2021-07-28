#!/bin/bash
set -e
AMP_CONFIG_FILE=config/appConfig.ini
FLUTTER_OPTIONS=()
for i in "$@"
do
case $i in
    --amp-config-file=*)
    AMP_CONFIG_FILE="${i#*=}"
    shift # past argument=value
    ;;
    *)
    FLUTTER_OPTIONS+=("$i")
    shift
    ;;
esac
done
IFS="="
dart_defines=()
while read -r key value
do
dart_defines+=("--dart-define=$key=$value")
done < $AMP_CONFIG_FILE
if [[ $(tail -c1 "$AMP_CONFIG_FILE" | wc -l) -eq 0 ]] 
then
    echo "$AMP_CONFIG_FILE must end with a newline" >> /dev/stderr
    exit 1
fi
echo flutter "${FLUTTER_OPTIONS[@]}" "${dart_defines[@]}"
flutter "${FLUTTER_OPTIONS[@]}" "${dart_defines[@]}"
