# AMP UI 

The Flutter UI for the Airmen Experience portion of AMP. 

## Getting Started

[Install Flutter](https://flutter.dev/docs/get-started/install), taking good care with the **[Update your path](https://flutter.dev/docs/get-started/install)** section. This project uses [Flutter Web](https://flutter.dev/web), so as of this writing you'll need to use the beta release of Flutter:

```bash
flutter channel beta
flutter upgrade
flutter config --enable-web
```

Once the environment is all set and `flutter doctor` produces good results, run `flutter pub get` in this repository's root directory to download the package dependencies.

## Running, debugging, etc

All build and run operations can be accomplished from within VSCode as well as at the terminal. See the Flutter documentation for [detailed instructions](https://flutter.dev/docs/get-started/test-drive?tab=vscode).

## Models

Do not edit `model.g.dart` directly! If you make changes to `model.dart`, run `flutter pub run build_runner build --delete-conflicting-outputs` to generate a new `model.g.dart`.

## Unit Tests

To run unit the tests locally, run:

`flutter test --coverage ./lib`

## Docker

You may notice that there is a Dockerfile in this repo. It's not really for local use, though. It's for testing and building the app in CI. When authenticated to the BESPIN GitLab's container registry via `docker login`, you can pull and push that image with `docker-compose pull` or `push` respectively.

# Pipeline
Current pipeline setup was pulled from both the MDaaS examples of android and ios apps and WFA as they have a working flutter pipeline.

MDaaS iOS example: https://gitlab-dev.bespinmobile.cloud/mdaas/ios-test-app

MDaaS Android example: https://gitlab-dev.bespinmobile.cloud/mdaas/android-test-app

WFA: https://gitlab-dev.bespinmobile.cloud/wingfeedback/ui/wfa_ui/-/tree/develop/

## Stages
Stages implemented at the moment are test, coverage, build, and scan in that order

The test phase not only runs the test but generates the coverage reports on lines covered

The coverage stage simply runs a script that checks if a merge request meets or exceeds the code coverage of the develop branch.

The build phase creates either a develop or release version of an apk and ipa and uploads them as an artifact.

The scan phase pulls these artifacts and scans the apk and ipa for vulnerabilities via NowSecure, as well as linting the actual code throught SonarQube

_TODO: Go more in depth into how all these steps are accomplished_