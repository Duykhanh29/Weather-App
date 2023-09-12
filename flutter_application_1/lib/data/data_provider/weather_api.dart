import 'dart:convert';

import 'package:flutter_application_1/data/models/local_data.dart';
import 'package:flutter_application_1/common/utils/contants/database_values.dart';
import 'package:http/http.dart' as http;

class WeatherAPI {
  Future<Map<String, dynamic>?> getRawWeather(String city) async {
    final String url =
        "${linkURL}/v1/forecast.json?key=${webKey}&q=${city}&days=3&aqi=yes";
    final data = await http.get(Uri.parse(url));
    if (data.statusCode == 200) {
      return json.decode(data.body) as Map<String, dynamic>;
    }
  }

  Future<Map<String, dynamic>?> getWeatherFromLongLat(
      double longitude, double latitude) async {
    final data = await http.get(Uri.parse(
        '${linkURL}/v1/forecast.json?key=${webKey}&q=${latitude},${longitude}&days=3&aqi=yes'));
    if (data.statusCode == 200) {
      return json.decode(data.body) as Map<String, dynamic>;
    }
  }

  List<String> getListcityInLocalStorage(List<LocalData> listData) {
    List<String> list = [];
    for (var data in listData) {
      list.add(data.city);
    }
    return list;
  }
}
