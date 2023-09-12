import 'package:flutter_application_1/data/models/forecast_hour.dart';
import 'package:flutter_application_1/common/utils/helpers/patterns.dart';

class CommondMethods {
  static List<ForecastDataHour> getDataHours(
      List<ForecastDataHour> listData, DateTime time) {
    List<ForecastDataHour> list = [];
    final currentTime = time.hour;
    for (var data in listData) {
      String convertedTime = Patterns.convertTimeToHourAndMinute(data.time!);
      if (Patterns.getCurrentHour(convertedTime) >= currentTime) {
        list.add(data);
      }
    }
    return list;
  }

  static String showBandFromAirQualityIndex(int index) {
    if (index <= 3) {
      return "Fresh and safe air";
    } else if (index <= 6) {
      return "Moderate";
    } else if (index <= 9) {
      return "Unhealthy for sensitive group";
    }
    return "Very Unhealthy";
  }
}
