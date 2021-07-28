// Imports the Flutter Driver API.
import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart' as FD;
import 'package:flutter_test/flutter_test.dart';
import '../lib/services/maestro.dart';
import '../lib/models/model.dart';

void main() {
  group('Category List', () {
    List<FD.SerializableFinder> expansionTileFinders;

    // for (Category category in Maestro.checklist.categories) {
    //   expansionTileFinders.add(FD.find.byValueKey(PageStorageKey<String>(category.title)));
    // }

    FD.FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FD.FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    // test('tiles start in closed state', () async {
    //   expansionTileFinders.asMap().forEach((index, finder) async {
    //     expect(await driver.getText(finder), Maestro.checklist.categories[index].title);
    //   });
    // });

    test('increments the counter', () async {
      // First, tap the button.
      // await driver.tap(buttonFinder);

      // // Then, verify the counter text is incremented by 1.
      // expect(await driver.getText(counterTextFinder), "1");
    });
  });
}