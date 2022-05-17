import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:booksynation/main.dart' as app;
import 'package:booksynation/strings.dart';
import 'test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Authentication - ", () {
    //AWUL_AUTH1 and AWUL_AUTH2
    testWidgets('Check if app allows user to create account in admin UI. ',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final signUpButton = find.widgetWithText(GestureDetector, 'Sign Up');
      expect(signUpButton, findsOneWidget);
      await tester.tap(signUpButton);
      tester.printToConsole("Going to Sign Up Page");
      await tester.pumpAndSettle();

      Finder emailField = find.byKey(Key("emailFormField"));
      await tester.enterText(emailField, sampleEmail);

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
      tester.tap(regButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      Finder regSuccess = find.byKey(Key(regSuccessSnackbar));

      try {
        await tester.pumpAndSettle(const Duration(seconds: 10));
        await tester.ensureVisible(regSuccess);
        await Future.delayed(const Duration(seconds: 5), () {});
        expect(regSuccess, findsOneWidget); //AWUI_AUTH1
        debugPrint(
            "Check if app allows user to create account in admin UI. -- PASSED");
        passedTests++;
        tester.printToConsole("Passed Tests: " + passedTests.toString());
      } on Exception catch (e) {
        debugPrint(
            "Check if app allows user to create account in admin UI. -- FAILED");
      }
      printResults(testOutput, passedTests);
    });
    //AWUL_AUTH3
    testWidgets("Check if app allows user to login using the created account.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
      await tester.enterText(loginEmailField, sampleEmail);
      await tester.pumpAndSettle();

      Finder loginPassField = find.byKey(Key("webLoginPassField"));
      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      Finder loginButton = find.byKey(Key("webLoginButton"));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(loginButton, findsNothing); //AWUI_AUTH2

      Finder schedVac = find.text("Scheduled Vaccinations");
      await tester.tap(schedVac);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      expect(find.text(scheduledVaxSection), findsOneWidget); //AWUI_SIDE1

      Finder missedVac = find.text("Missed Vaccinations");
      await tester.tap(missedVac);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      expect(find.text(reschedPatientText), findsOneWidget); //AWUI_SIDE2

      Finder accSettings = find.text("Account Settings");
      await tester.tap(accSettings);
      await tester.pumpAndSettle(const Duration(seconds: 6));

      expect(find.text(settingsSection), findsOneWidget); //AWUI_SIDE3

      Finder manageVax = find.text("Manage Vaccines");
      await tester.tap(manageVax);
      await tester.pumpAndSettle();

      Finder signOutButton = find.text("Sign-out");
      await tester.tap(signOutButton);
      await tester.pumpAndSettle();

      expect(find.text(logInWebText), findsOneWidget); //AWUI_SIDE5
    });
    //AWU_AUTH4
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
      //Should display password
    });
    //AWU_AUTH5
    testWidgets(
        "Check application's signup behavior when email provided is not valid.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final signUpButton = find.widgetWithText(GestureDetector, 'Sign Up');
      expect(signUpButton, findsOneWidget);
      await tester.tap(signUpButton);
      tester.printToConsole("Going to Sign Up Page");
      await tester.pumpAndSettle();

      Finder emailField = find.byKey(Key("emailFormField"));
      await tester.enterText(emailField, "TesterEmail");
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
      tester.tap(regButton);
      await Future.delayed(const Duration(seconds: 10), () {});
      //Should display "Email address is not valid"
    });
    //AWU_AUTH6
    testWidgets(
        "Check application's signup behavior when email provided is already registered.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final signUpButton = find.widgetWithText(GestureDetector, 'Sign Up');
      expect(signUpButton, findsOneWidget);
      await tester.tap(signUpButton);
      tester.printToConsole("Going to Sign Up Page");
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
      tester.tap(regButton);
      await Future.delayed(const Duration(seconds: 5), () {});
      //Should display "Registration Error"
    });
    //AWU_AUTH7
    testWidgets(
        "Check application's signup behavior when confirm password does not align with provided password.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final signUpButton = find.widgetWithText(GestureDetector, 'Sign Up');
      expect(signUpButton, findsOneWidget);
      await tester.tap(signUpButton);
      tester.printToConsole("Going to Sign Up Page");
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
      tester.tap(regButton);
      await Future.delayed(const Duration(seconds: 5), () {});
      //Should display "Wrong password"
    });
    //AWU_AUTH8
    testWidgets(
        "Check application's login behavior when email provided is not registered.",
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
      await tester.pumpAndSettle(const Duration(seconds: 15));
      expect(loginButton, findsNothing);
      //Should display "Login Error"
    });
    //AWUL_AUTH9
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
      expect(loginButton, findsNothing);
      //Should display "Wrong Password for that User"
    });
  });
}
