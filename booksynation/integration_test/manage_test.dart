import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:booksynation/main.dart' as app;
import 'test_helpers.dart';

void main() {
  List<String> testOutput = [];
  int passedTests = 0;
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Manage Vaccines - ", () {
    testWidgets("Test vaccine filter feature", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(loginEmailField, "docadam@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      await tester.tap(vaxDateStart);
      await tester.pumpAndSettle();

      await tester.tap(find.text(now.day.toString()));
      await tester.pumpAndSettle();

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      try {
        //AWUI_MVAC1
        expect(find.text(testDate.toString()), findsOneWidget);
        testOutput.add(
            "Check if date picker widget data corresponds to the picked date when setting the Vaccination Start date. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if date picker widget data corresponds to the picked date when setting the Vaccination Start date. -- FAILED");
      }

      await tester.tap(vaxDateEnd);
      await tester.pumpAndSettle();

      final endDate = now.add(Duration(days: 7)); //end date is one week after

      if (endDate.month == now.month) {
        await tester.tap(find.text(endDate.day.toString()));
      } else {
        await tester.tap(find.byTooltip('Next month'));
        await tester.pumpAndSettle();
        await tester.tap(find.text(endDate.day.toString()));
      }
      await tester.pumpAndSettle();

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      try {
        //AWUI_MVAC2
        expect(
            find.text(dateFormat.format(now.add(Duration(days: 7))).toString()),
            findsOneWidget);
        testOutput.add(
            "Check if date picker widget data corresponds to the picked date when setting the Vaccination Start date. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if date picker widget data corresponds to the picked date when setting the Vaccination Start date. -- FAILED");
      }

      await tester.tap(stockField);
      await tester.enterText(stockField, "50");
      await tester.pumpAndSettle();

      await tester.tap(vaxDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "Astrazeneca"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "Astrazeneca"),
            findsOneWidget);
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Astrazeneca. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Astrazeneca. -- FAILED");
      }

      await tester.tap(vaxDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "Janssen"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "Janssen"),
            findsOneWidget);
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Janssen. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Janssen. -- FAILED");
      }

      await tester.tap(vaxDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "Moderna"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "Moderna"),
            findsOneWidget);
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Janssen. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Janssen. -- FAILED");
      }

      await tester.tap(vaxDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "Pfizer"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "Pfizer"),
            findsOneWidget);
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Janssen. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Janssen. -- FAILED");
      }

      await tester.tap(vaxDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "Sinovac"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "Sinovac"),
            findsOneWidget);
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Janssen. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Vaccine Dropdown shows the chosen vaccine type correctly: Janssen. -- FAILED");
      }

      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "A1"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "A1"),
            findsOneWidget);
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A1. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A1. -- FAILED");
      }

      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "A2"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "A2"),
            findsOneWidget);
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A2. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A2. -- FAILED");
      }

      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "A3"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "A3"),
            findsOneWidget);
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A3. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A3. -- FAILED");
      }

      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "A4"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "A4"),
            findsOneWidget);
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A4. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A4. -- FAILED");
      }

      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(KeepAlive, "A5"));
      await tester.pumpAndSettle();

      try {
        expect(find.widgetWithText(DropdownButtonHideUnderline, "A5"),
            findsOneWidget);
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A5. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if Category Dropdown shows the chosen category correctly: A5. -- FAILED");
      }

      await Future.delayed(const Duration(seconds: 10), () {});
      printResults(testOutput, passedTests);
    });
  });
}
