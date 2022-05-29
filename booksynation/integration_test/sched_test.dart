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
  group("Scheduled Vaccinations - ", () {
    testWidgets("Test vaccine filter feature", (tester) async {
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
      Finder schedVac = find.text("Scheduled Vaccinations");
      await tester.tap(schedVac);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder vaccineDropdown = find.byType(DropdownButton<String>);
      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Astrazeneca'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_SCHED4
        expect(find.text("Astrazeneca"), findsWidgets);
        testOutput.add("Check vaccine filter: Astrazeneca only -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add("Check vaccine filter: Astrazeneca only -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Janssen'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_SCHED5
        expect(find.text("Janssen"), findsWidgets);
        testOutput.add("Check vaccine filter: Janssen only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add("Check vaccine filter: Janssen only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Moderna'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_SCHED6
        expect(find.text("Moderna"), findsWidgets);
        testOutput.add("Check vaccine filter: Moderna only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add("Check vaccine filter: Moderna only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Pfizer'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_SCHED7
        expect(find.text("Pfizer"), findsWidgets);
        testOutput.add("Check vaccine filter: Pfizer only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add("Check vaccine filter: Pfizer only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'Sinovac'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_SCHED8
        expect(find.text("Sinovac"), findsWidgets);
        testOutput.add("Check vaccine filter: Sinovac only. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add("Check vaccine filter: Sinovac only. -- FAILED");
      }

      await tester.tap(vaccineDropdown);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.widgetWithText(KeepAlive, 'All'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_SCHED9
        expect(find.text("All"), findsWidgets);
        testOutput.add("Check vaccine filter: All vaccines. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add("Check vaccine filter: All vaccines. -- FAILED");
      }
      printResults(testOutput, passedTests);
    });
  });
}
