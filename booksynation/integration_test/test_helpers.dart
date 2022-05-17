import 'package:intl/intl.dart';

List<String> testOutput = [];
int passedTests = 0;

DateTime now = DateTime.now();
var dateFormat = new DateFormat('MMddyy-mm');

var dateWithTimeFormat = new DateFormat("yyyy-MM-dd HH:mm:ss");
String testDate = dateFormat.format(now);
String testDateWithTime = dateWithTimeFormat.format(now);
String sampleEmail = "test" + testDate + "@email.com";

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
    } else {
      printFailed(result);
    }
  }
  print("$successCount/${results.length} passed the test.");
}
