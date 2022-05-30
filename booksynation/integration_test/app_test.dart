import 'package:file_picker/file_picker.dart';
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

  String testEmailInstance = sampleEmail;

  group("Authentication - ", () {
    testWidgets('Register an account', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      testOutput.add("\n\nTest Results -- " + testDateWithTime + "\n");

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

      await tester.enterText(emailField, testEmailInstance);

      await tester.enterText(firstNameField, "Test");

      await tester.enterText(lastNameField, "Account");

      await tester.enterText(passField, "P@ssword");
      await tester.enterText(confirmPass, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(regButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5), () {});

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

      await tester.enterText(loginEmailField, testEmailInstance);
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

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

      await tester.enterText(loginEmailField, "claudettelaroa@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "pass123");
      await tester.pumpAndSettle();

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

      await tester.enterText(emailField, "TesterEmail-testmail.com");

      await tester.enterText(firstNameField, "Test");

      await tester.enterText(lastNameField, "Account");

      await tester.enterText(passField, "P@ssword");
      await tester.enterText(confirmPass, "P@ssword");
      await tester.pumpAndSettle();

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

      await tester.enterText(emailField, "claudettelaroa@gmail.com");

      await tester.enterText(firstNameField, "Test");

      await tester.enterText(lastNameField, "Account");

      await tester.enterText(passField, "P@ssword");
      await tester.enterText(confirmPass, "P@ssword");
      await tester.pumpAndSettle();

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

      await tester.enterText(emailField, "testemail@gmail.com");

      await tester.enterText(firstNameField, "Test");

      await tester.enterText(lastNameField, "Account");

      await tester.enterText(passField, "P@ssword");
      await tester.enterText(confirmPass, "P@ss123");
      await tester.pumpAndSettle();

      await tester.tap(regButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await Future.delayed(const Duration(seconds: 5), () {});

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

      await tester.enterText(loginEmailField, "claudettelaroa");
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "pass123");
      await tester.pumpAndSettle();

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

      await tester.enterText(loginEmailField, "claudettelaroa@gmali.com");
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "pass123");
      await tester.pumpAndSettle();

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

      await tester.enterText(loginEmailField, "claudettelaroa@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "password");
      await tester.pumpAndSettle();

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

      await tester.enterText(loginEmailField, testEmailInstance);
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      try {
        expect(find.text(testEmailInstance), findsOneWidget);
        testOutput.add(
            "Check if the created account email is the same in Side Menu. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if the created account email is the same in Side Menu. -- FAILED");
      }

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

      await tester.enterText(loginEmailField, testEmailInstance);
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));

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
    });
  });

  group("Scheduled Vaccinations - ", () {
    testWidgets("Test vaccine filter feature", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(loginEmailField, testEmailInstance);
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      await tester.tap(schedVac);
      await tester.pumpAndSettle(const Duration(seconds: 5));

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
    });
  });

  group("Missed Vaccines ", () {
    //AWUL_AUTH3
    testWidgets(
        "Check if app allows user to manage missed vaccination schedules.",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(loginEmailField, "docadam@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));

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

      await tester.tap(patientToRemove);
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

      await tester.tap(patientToRemove);
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

      await tester.tap(manageVax);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5), () {});
    });
  });
  group("Account Settings - ", () {
    testWidgets('Profile picture change and password change test cases.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(loginEmailField, testEmailInstance);
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(passVisib);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      await tester.tap(find.text("Account Settings"));
      await tester.pumpAndSettle();

      await tester.tap(changePicButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      try {
        //AWUI_SETNG1
        expect(find.byType(FilePicker), findsOneWidget);
        testOutput.add(
            "Check if app allows user to change the account profile picture. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if app allows user to change the account profile picture. -- FAILED");
      }

      await tester.tap(currentPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(newPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "new_pass");
      await tester.pumpAndSettle();

      await tester.tap(saveChangesButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));
      await Future.delayed(const Duration(seconds: 5), () {});

      try {
        //AWUI_SETNG2
        expect(saveChangesButton, findsNothing);
        testOutput.add(
            "Check if app allows user to change the account password. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if app allows user to change the account password. -- FAILED");
      }

      await tester.enterText(loginEmailField, testEmailInstance);
      await tester.pumpAndSettle();

      await tester.enterText(loginPassField, "new_pass");
      await tester.pumpAndSettle();

      await tester.tap(passVisib);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      try {
        //AWUI_SETNG3
        expect(loginButton, findsNothing);
        testOutput.add(
            "Check if app allows user to login with the new password. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if app allows user to login with the new password. -- FAILED");
      }
      await tester.tap(find.text("Account Settings"));
      await tester.pumpAndSettle();

      await tester.tap(saveChangesButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      try {
        //AWUI_SETNG4
        expect(
            find.widgetWithText(SnackBar, reviewFieldErrMsg), findsOneWidget);
        testOutput.add(
            "Check app behavior when Save Changes button is clicked while fields are empty. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when Save Changes button is clicked while fields are empty. -- FAILED");
      }

      await tester.tap(currentPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "new_pass");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(saveChangesButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      try {
        //AWUI_SETNG5
        expect(find.text('Please input new password.'), findsOneWidget);
        testOutput.add(
            "Check app behavior when trying to change password but New Password field is empty. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when trying to change password but New Password field is empty. -- FAILED");
      }

      await tester.tap(currentPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "incorrect");
      await tester.pumpAndSettle();

      await tester.tap(newPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "wrongpassword");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(saveChangesButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      try {
        //AWUI_SETNG6
        expect(find.text('Please input current password.'), findsOneWidget);
        testOutput.add(
            "Check app behavior when the password entered in Current Password field is incorrect. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check app behavior when the password entered in Current Password field is incorrect. -- FAILED");
      }

      await tester.tap(currentPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "new_pass");
      await tester.pumpAndSettle();

      await tester.tap(newPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "weak");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(saveChangesButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      try {
        //AWUI_SETNG7
        expect(find.widgetWithText(SnackBar, passWeakSnackbar), findsOneWidget);
        testOutput.add(
            "Check if app allows user to enter password with less than 6 characters. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check if app allows user to enter password with less than 6 characters. -- FAILED");
      }
      await tester.tap(currentPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "");
      await tester.pumpAndSettle();

      await tester.tap(newPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "");
      await tester.pumpAndSettle();

      try {
        //AWUI_SETNG8
        await tester.tap(changePicButton);
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(find.byType(FilePicker), findsOneWidget);

        await tester.tap(saveChangesButton);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        expect(
            find.widgetWithText(SnackBar, reviewFieldErrMsg), findsOneWidget);
        testOutput.add(
            "Check error handling when user tries to save changes without confirming password or entering new password. -- PASSED");
        passedTests++;
      } catch (error) {
        testOutput.add(
            "Check error handling when user tries to save changes without confirming password or entering new password. -- FAILED");
      }

      await tester.tap(currentPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "new_pass");
      await tester.pumpAndSettle();

      await tester.tap(newPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(saveChangesButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      printResults(testOutput, passedTests);
    });
  });
}
