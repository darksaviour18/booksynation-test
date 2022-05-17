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
      testOutput.add("Test Results -- " + testDateWithTime);

      final Finder signUpButton =
          find.widgetWithText(GestureDetector, 'Sign Up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();
      try {
        //AWUI_AUTH1
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
      final Finder regSuccess = find.text(regSuccessSnackbar);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 10), () {});

      try {
        //AWUI_AUTH2
        expect(regSuccess, findsOneWidget);
        testOutput.add(
            "Check if app allows user to create account in admin UI. -- PASSED");
        passedTests++;
        tester.printToConsole("Passed Tests: " + passedTests.toString());
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
        //AWUI_AUTH3
        expect(loginButton, findsNothing);
        testOutput.add(
            "Check if app allows user to login using the created account. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if app allows user to login using the created account. -- FAILED");
      }
    });

    testWidgets("Check password visibility feature", (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
      await tester.enterText(loginEmailField, "claudettelaroa@gmail.com");
      await tester.pumpAndSettle();
      Finder loginPassField = find.byKey(Key("webLoginPassField"));
      await tester.enterText(loginPassField, "pass123");
      await tester.pumpAndSettle();
      Finder passVisib = find.byKey(Key("passVisibIcon"));
      await tester.tap(passVisib);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      TextFormField loginPassFieldReference =
          tester.widget<TextFormField>(loginPassField);
      try {
        //AWUI_AUTH4
        expect(loginPassFieldReference.controller!.text, "pass123");
        testOutput.add("Check if password visibility button works. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add("Check if password visibility button works. -- FAILED");
      }
    });

    testWidgets(
        "Check application's signup behavior when email provided is not valid.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final signUpButton = find.widgetWithText(GestureDetector, 'Sign Up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      Finder emailField = find.byKey(Key("emailFormField"));
      await tester.enterText(emailField, "TesterEmail-testmail.com");
      Finder firstNameField = find.byKey(Key("regFirstNameForm"));
      await tester.enterText(firstNameField, "Test");
      Finder lastNameField = find.byKey(Key("regLastNameForm"));
      await tester.enterText(lastNameField, "Account");
      Finder passField = find.byKey(Key("regPassField"));
      Finder confirmPass = find.byKey(Key("regConfirmPassField"));

      await tester.enterText(passField, "P@ssword");
      await tester.enterText(confirmPass, "P@ssword");
      await tester.pumpAndSettle();

      Finder regButton = find.byKey(Key("regButton"));
      await tester.tap(regButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await Future.delayed(const Duration(seconds: 10), () {});
      try {
        //AWUI_AUTH5
        expect(find.widgetWithText(SnackBar, invalidEmailSnackbar),
            findsOneWidget);
        testOutput.add(
            "Check error handling when invalid email format is entered. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check error handling when invalid email format is entered. -- FAILED");
      }
    });
    testWidgets(
        "Check application's signup behavior when email provided is already registered.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final signUpButton = find.widgetWithText(GestureDetector, 'Sign Up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      Finder emailField = find.byKey(Key("emailFormField"));
      await tester.enterText(emailField, "claudettelaroa@gmail.com");
      Finder firstNameField = find.byKey(Key("regFirstNameForm"));
      await tester.enterText(firstNameField, "Test");
      Finder lastNameField = find.byKey(Key("regLastNameForm"));
      await tester.enterText(lastNameField, "Account");
      Finder passField = find.byKey(Key("regPassField"));
      Finder confirmPass = find.byKey(Key("regConfirmPassField"));
      await tester.enterText(passField, "P@ssword");
      await tester.enterText(confirmPass, "P@ssword");
      await tester.pumpAndSettle();
      Finder regButton = find.byKey(Key("regButton"));
      await tester.tap(regButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await Future.delayed(const Duration(seconds: 5), () {});

      try {
        //AWUI_AUTH6
        expect(
            find.widgetWithText(SnackBar, emailInUseSnackbar), findsOneWidget);
        testOutput.add(
            "Check error handling when the input email address is already registered. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check error handling when the input email address is already registered. -- FAILED");
      }
    });

    testWidgets(
        "Check application's signup behavior when confirm password does not align with provided password.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final signUpButton = find.widgetWithText(GestureDetector, 'Sign Up');
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      Finder emailField = find.byKey(Key("emailFormField"));
      await tester.enterText(emailField, "testemail@gmail.com");
      Finder firstNameField = find.byKey(Key("regFirstNameForm"));
      await tester.enterText(firstNameField, "Test");
      Finder lastNameField = find.byKey(Key("regLastNameForm"));
      await tester.enterText(lastNameField, "Account");
      Finder passField = find.byKey(Key("regPassField"));
      Finder confirmPass = find.byKey(Key("regConfirmPassField"));
      await tester.enterText(passField, "P@ssword");
      await tester.enterText(confirmPass, "P@ss123");
      await tester.pumpAndSettle();
      Finder regButton = find.byKey(Key("regButton"));
      await tester.tap(regButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await Future.delayed(const Duration(seconds: 5), () {});
      TextFormField regPassFieldReference =
          tester.widget<TextFormField>(passField);
      try {
        //AWU_AUTH7
        expect(find.text("Wrong password"), findsOneWidget);
        testOutput.add(
            "Check error handling when the Password and Confirm Password inputs do not match. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check error handling when the Password and Confirm Password inputs do not match. -- FAILED");
      }
    });
    testWidgets(
        "Check application's login behavior when email provided is invalid format.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
      await tester.enterText(loginEmailField, "claudettelaroa");
      await tester.pumpAndSettle();
      Finder loginPassField = find.byKey(Key("webLoginPassField"));
      await tester.enterText(loginPassField, "pass123");
      await tester.pumpAndSettle();
      Finder loginButton = find.byKey(Key("webLoginButton"));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5), () {});
      try {
        //AWUI_AUTH8
        expect(
            find.widgetWithText(SnackBar, loginErrorSnackbar), findsOneWidget);
        testOutput.add(
            "Check error handling when the input email address is invalid format. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check error handling when the input email address is invalid format. -- FAILED");
      }
    });
    testWidgets(
        "Check application's login behavior when email is not registered.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
      await tester.enterText(loginEmailField, "claudettelaroa@gmali.com");
      await tester.pumpAndSettle();
      Finder loginPassField = find.byKey(Key("webLoginPassField"));
      await tester.enterText(loginPassField, "pass123");
      await tester.pumpAndSettle();
      Finder loginButton = find.byKey(Key("webLoginButton"));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5), () {});

      try {
        //AWUI_AUTH9
        expect(find.widgetWithText(SnackBar, noUserSnackbar), findsOneWidget);
        testOutput.add(
            "Check error handling when email is not registered. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check error handling when email is not registered. -- FAILED");
      }
    });
    testWidgets(
        "Check application's login behavior when password provided is incorrect.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
      await tester.enterText(loginEmailField, "claudettelaroa@gmail.com");
      await tester.pumpAndSettle();
      Finder loginPassField = find.byKey(Key("webLoginPassField"));
      await tester.enterText(loginPassField, "password");
      await tester.pumpAndSettle();
      Finder loginButton = find.byKey(Key("webLoginButton"));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));
      await Future.delayed(const Duration(seconds: 5), () {});
      try {
        //AWUI_AUTH10
        expect(
            find.widgetWithText(SnackBar, wrongPassSnackbar), findsOneWidget);
        testOutput
            .add("Check error handling when password is incorrect. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput
            .add("Check error handling when password is incorrect. -- FAILED");
      }
    });
  });

  group("Side Menu - ", () {
    testWidgets("Side Menu navigation tests", (tester) async {
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

      final Finder schedVac = find.text("Scheduled Vaccinations");
      await tester.tap(schedVac);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      try {
        expect(find.text(scheduledVaxSection), findsOneWidget);
        testOutput.add(
            "Check app behavior when clicking the Scheduled Vaccinations item. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when clicking the Scheduled Vaccinations item. -- FAILED");
      } //AWUI_SIDE1

      final Finder missedVac = find.text("Missed Vaccinations");
      await tester.tap(missedVac);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      try {
        expect(find.text(reschedPatientText), findsOneWidget);
        testOutput.add(
            "Check app behavior when clicking the Missed Vaccinations item. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when clicking the Missed Vaccinations item. -- FAILED");
      } //AWUI_SIDE2

      final Finder accSettings = find.text("Account Settings");
      await tester.tap(accSettings);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      try {
        expect(find.text(settingsSection), findsOneWidget);
        testOutput.add(
            "Check app behavior when clicking the Account Settings item. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when clicking the Account Settings item. -- FAILED");
      } //AWUI_SIDE3

      final Finder manageVax = find.text("Manage Vaccines");
      await tester.tap(manageVax);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      try {
        expect(find.text(vaxStartText), findsOneWidget);
        testOutput.add(
            "Check app behavior when clicking the Manage Vaccines item. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when clicking the Manage Vaccines item. -- FAILED");
      }
    });
    testWidgets("Sign-out button test", (tester) async {
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

      final Finder signOutButton = find.text("Sign-out");
      await tester.tap(signOutButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      try {
        expect(find.text(logInWebText), findsOneWidget);
        testOutput.add(
            "Check app behavior when clicking the Sign-out item. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when clicking the Sign-out item. -- FAILED");
      } //AWUI_SIDE5
      printResults(testOutput, passedTests);
    });
  });
}
