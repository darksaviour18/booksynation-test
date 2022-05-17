import 'package:firebase_auth/firebase_auth.dart';
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

  group("Authentication - ", () {
    testWidgets('Register an account', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder signUpButton =
          find.widgetWithText(GestureDetector, 'Sign Up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();
      try {
        expect(signUpButton, findsNothing);
        testOutput.add(
            "Check if tapping Sign Up text redirects user to Sign Up page. -- PASSED");
        passedTests++;
      } on Exception catch (e) {
        testOutput.add(
            "Check if tapping Sign Up text redirects user to Sign Up page. -- FAILED");
      }

      final Finder emailField = find.byKey(Key("emailFormField"));
      await tester.enterText(emailField, sampleEmail);

      final Finder firstNameField = find.byKey(Key("regFirstNameForm"));
      await tester.enterText(firstNameField, "Test");

      final Finder lastNameField = find.byKey(Key("regLastNameForm"));
      await tester.enterText(lastNameField, "Account");
      final Finder passField = find.byKey(Key("regPassField"));
      final Finder confirmPass = find.byKey(Key("regConfirmPassField"));

      await tester.enterText(passField, "P@ssword");
      await tester.enterText(confirmPass, "P@ssword");
      await tester.pumpAndSettle();

      final Finder regButton = find.byKey(Key("regButton"));
      await tester.tap(regButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final Finder regSuccess = find.byKey(Key(regSuccessSnackbar));
      await tester.ensureVisible(regSuccess);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      try {
        expect(regSuccess, findsOneWidget); //AWUI_AUTH1
        testOutput.add(
            "Check if app allows user to create account in admin UI. -- PASSED");
        passedTests++;
        tester.printToConsole("Passed Tests: " + passedTests.toString());
      } on FirebaseAuthException catch (e) {
        testOutput.add(
            "Check if app allows user to create account in admin UI. -- FAILED");
      } catch (error) {
        testOutput.add(
            "Check if app allows user to create account in admin UI. -- FAILED");
      }
    });
    testWidgets('Login account and check side menu navigation', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
      await tester.enterText(loginEmailField, sampleEmail);
      await tester.pumpAndSettle();

      final Finder loginPassField = find.byKey(Key("webLoginPassField"));
      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      final Finder loginButton = find.byKey(Key("webLoginButton"));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));
      try {
        expect(loginButton, findsNothing);
        testOutput.add(
            "Check if app allows user to login using the created account. -- PASSED");
        passedTests++;
      } on Exception catch (e) {
        testOutput.add(
            "Check if app allows user to login using the created account. -- FAILED");
      } //AWUI_AUTH2

      final Finder schedVac = find.text("Scheduled Vaccinations");
      await tester.tap(schedVac);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text(scheduledVaxSection), findsOneWidget); //AWUI_SIDE1

      final Finder missedVac = find.text("Missed Vaccinations");
      await tester.tap(missedVac);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text(reschedPatientText), findsOneWidget); //AWUI_SIDE2

      final Finder accSettings = find.text("Account Settings");
      await tester.tap(accSettings);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text(settingsSection), findsOneWidget); //AWUI_SIDE3

      final Finder manageVax = find.text("Manage Vaccines");
      await tester.tap(manageVax);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final Finder signOutButton = find.text("Sign-out");
      await tester.tap(signOutButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text(logInWebText), findsOneWidget); //AWUI_SIDE5
      printResults(testOutput, passedTests);
    });
  });
}
