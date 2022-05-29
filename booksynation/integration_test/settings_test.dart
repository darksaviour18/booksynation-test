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

  group("Account Settings - ", () {
    testWidgets('Profile picture change and password change test cases.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
      await tester.enterText(loginEmailField, "docadam@gmail.com");
      await tester.pumpAndSettle();

      final Finder loginPassField = find.byKey(Key("webLoginPassField"));
      await tester.enterText(loginPassField, "P@ssword");
      await tester.pumpAndSettle();

      Finder passVisib = find.byKey(Key("passVisibIcon"));
      await tester.tap(passVisib);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder loginButton = find.byKey(Key("webLoginButton"));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 7));

      await tester.tap(find.text("Account Settings"));
      await tester.pumpAndSettle();

      final Finder changePicButton = find.byIcon(Icons.add_a_photo);

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

      final Finder currentPassField =
          find.widgetWithText(TextFormField, "Current Password");
      final Finder newPassField =
          find.widgetWithText(TextFormField, "New Password");

      await tester.tap(currentPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "P@ssword");
      await tester.pumpAndSettle();

      await tester.tap(newPassField);
      await tester.pumpAndSettle();
      await tester.enterText(currentPassField, "new_pass");
      await tester.pumpAndSettle();

      final Finder saveChangesButton =
          find.widgetWithText(ElevatedButton, btnTextSave);
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

      await tester.enterText(loginEmailField, "docadam@gmail.com");
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
