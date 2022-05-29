import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booksynation/strings.dart';

DateTime now = DateTime.now();
var dateFormat = new DateFormat('MMddyy-HHmm');

var dateWithTimeFormat = new DateFormat("yyyy-MM-dd HH:mm:ss");
String testDate = dateFormat.format(now);
String testDateWithTime = dateWithTimeFormat.format(now);
String sampleEmail = "test" + testDate + "@email.com";

//Finders
final Finder signUpButton = find.widgetWithText(GestureDetector, 'Sign Up');
final Finder emailField = find.byKey(Key("emailFormField"));
final Finder firstNameField = find.byKey(Key("regFirstNameForm"));
final Finder lastNameField = find.byKey(Key("regLastNameForm"));
final Finder passField = find.byKey(Key("regPassField"));
final Finder confirmPass = find.byKey(Key("regConfirmPassField"));
final Finder regButton = find.byKey(Key("regButton"));
final Finder regSuccess = find.text(regSuccessSnackbar);
final Finder loginEmailField = find.byKey(Key("webLoginEmailField"));
final Finder loginPassField = find.byKey(Key("webLoginPassField"));
final Finder loginButton = find.byKey(Key("webLoginButton"));
final Finder passVisib = find.byKey(Key("passVisibIcon"));
final Finder schedVac = find.text("Scheduled Vaccinations");
final Finder missedVac = find.text("Missed Vaccinations");
final Finder accSettings = find.text("Account Settings");
final Finder manageVax = find.text("Manage Vaccines");
final Finder signOutButton = find.text("Sign-out");
final Finder vaccineDropdown = find.byType(DropdownButton<String>);
final Finder changePicButton = find.byIcon(Icons.add_a_photo);
final Finder currentPassField =
    find.widgetWithText(TextFormField, "Current Password");
final Finder newPassField = find.widgetWithText(TextFormField, "New Password");
final Finder saveChangesButton =
    find.widgetWithText(ElevatedButton, btnTextSave);

void printFailed(String text) {
  print('\x1B[41m$text\x1B[0m');
}

void printSuccess(String text) {
  print('\x1B[42m$text\x1B[0m');
}

void printResults(List<String> results, int successCount) {
  for (String result in results) {
    if (result.contains("PASSED")) {
      printSuccess(result);
    } else if (result.contains("FAILED")) {
      printFailed(result);
    } else {
      print(result);
    }
  }
  print("$successCount/${results.length - 1} passed the test.");
}
