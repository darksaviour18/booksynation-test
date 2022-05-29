import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:booksynation/main.dart' as app;
import 'package:booksynation/strings.dart';
import 'test_helpers.dart';

void main() {
  List<String> testOutput = [];
  int passedTests = 0;
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Missed Vaccines ", () {
    //AWUL_AUTH3
    testWidgets(
        "Check if app allows user to manage missed vaccination schedules.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
      await tester.enterText(loginEmailField, "docadam@gmail.com");
      await tester.pumpAndSettle();
      Finder loginPassField = find.byKey(Key("webLoginPassField"));
      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();
      Finder loginButton = find.byKey(Key("webLoginButton"));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));
      Finder missedVac = find.text(missedVaxSection);
      await tester.tap(missedVac);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(find.text("Dlar Ry Skie"));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.tap(find.text("Reschedule Patient"));
      await tester.pumpAndSettle(const Duration(seconds: 7));
      try {
        //AWUI_MISS1
        expect(find.text('Dlar Ry Skie'), findsNothing);
        testOutput.add(
            "Check app behavior when Reschedule Patient button is clicked. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when Reschedule Patient button is clicked. -- FAILED");
      }

      await tester.tap(find.textContaining("Mervin"));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final firstCheckBox = find.byType(Checkbox).first;
      await tester.tap(firstCheckBox);
      await tester.pumpAndSettle(const Duration(milliseconds: 1000));

      final CheckBoxReference = tester.widget<Checkbox>(firstCheckBox);
      try {
        //AWUI_MISS3
        expect(CheckBoxReference.value, true);
        testOutput.add(
            "Check select all entries checkbox function in the data table. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check select all entries checkbox function in the data table. -- FAILED");
      }

      final Finder vaccineDropdown = find.byType(DropdownButton<String>);
      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Astrazeneca'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_MISSED4
        expect(find.text("Astrazeneca"), findsWidgets);
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Astrazeneca only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Astrazeneca only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Janssen'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_MISSED5
        expect(find.text("Janssen"), findsWidgets);
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Janssen only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Janssen only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Moderna'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_MISSED6
        expect(find.text("Moderna"), findsWidgets);
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Moderna only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Moderna only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Pfizer'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_MISSED7
        expect(find.text("Pfizer"), findsWidgets);
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Pfizer only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Pfizer only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Sinovac'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_MISSED8
        expect(find.text("Sinovac"), findsWidgets);
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Sinovac only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for Sinovac only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'All'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_MISSED9
        expect(find.text("All"), findsWidgets);
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for All vaccines. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check Sort Missed Vaccinations by Schedule for All vaccines. -- FAILED");
      }

      await tester.tap(find.textContaining("Mervin"));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Remove Patient"));
      await tester.pumpAndSettle(const Duration(seconds: 7));
      await Future.delayed(const Duration(seconds: 3), () {});

      try {
        expect(find.textContaining("Test"), findsNothing);
        testOutput.add(
            "Check app behavior when Remove Patient button is clicked. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when Remove Patient button is clicked. -- FAILED");
      } //AWUI_MISS2

      final Finder manageVax = find.text("Manage Vaccines");
      await tester.tap(manageVax);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5), () {});

      printResults(testOutput, passedTests);
    });
  });
}
