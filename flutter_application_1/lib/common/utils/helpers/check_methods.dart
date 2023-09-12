import 'package:flutter_application_1/common/utils/helpers/patterns.dart';

class CheckMethod {
  static bool isSameDay(String day) {
    String dateTime = Patterns.convertTimeToDateTime(day);
    List<String> parts = dateTime.split("-");
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int date = int.parse(parts[2]);
    if (year == DateTime.now().year &&
        month == DateTime.now().month &&
        date == DateTime.now().day) {
      return true;
    }
    return false;
  }
}
