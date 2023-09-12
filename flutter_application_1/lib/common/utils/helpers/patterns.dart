import 'package:intl/intl.dart';

class Patterns {
  static String removeDiacritics(String input) {
    return "fg";
  }

  static String convertTimeToHourAndMinute(String time) {
    final List<String> parts = time.split(" ");
    return parts[1];
  }

  static String convertTimeToDateTime(String time) {
    final List<String> parts = time.split(" ");
    return parts[0];
  }

  static int getCurrentHour(String time) {
    final List<String> parts = time.split(":");
    return int.parse(parts[0]);
  }

  static DateTime getDateTimeByString(String dateTime) {
    final date = DateFormat('yyyy-MM-dd').parse(dateTime);
    return date;
  }

  static DateTime getDateTimeToHourByString(String dateTime) {
    final date = DateFormat('yyyy-MM-dd HH:mm').parse(dateTime);
    return date;
  }
}
