import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:booksynation/main.dart' as app;
import 'package:booksynation/web_pages/webregister.dart';
import 'test_helpers.dart';
import 'package:flutter/material.dart';
import 'package:booksynation/strings.dart';

void testAuth() {
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
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, sampleEmail);

    Finder firstNameField = find.byKey(Key("regFirstNameForm"));
    expect(firstNameField, findsOneWidget);
    await tester.enterText(firstNameField, "Test");

    Finder lastNameField = find.byKey(Key("regLastNameForm"));
    expect(lastNameField, findsOneWidget);
    await tester.enterText(lastNameField, "Account");
    Finder passField = find.byKey(Key("regPassField"));
    expect(passField, findsOneWidget);
    Finder confirmPass = find.byKey(Key("regConfirmPassField"));
    expect(confirmPass, findsOneWidget);

    await tester.enterText(passField, "P@ssword");
    await tester.enterText(confirmPass, "P@ssword");
    await tester.pumpAndSettle();

    Finder regButton = find.byKey(Key("regButton"));
    expect(regButton, findsOneWidget);
    tester.tap(regButton);
    await tester.pumpAndSettle(const Duration(seconds: 10));

    Finder regSuccess = find.byKey(Key(regSuccessSnackbar));

    try {
      await tester.ensureVisible(regSuccess);
      await Future.delayed(const Duration(seconds: 5), () {});
      expect(regSuccess, findsOneWidget);
      debugPrint(
          "Check if app allows user to create account in admin UI. -- PASSED");
      passedTests++;
      tester.printToConsole("Passed Tests: " + passedTests.toString());
    } catch (e) {
      debugPrint(
          "Check if app allows user to create account in admin UI. -- FAILED");
    }
    printResults(testOutput, passedTests);
  });
}
