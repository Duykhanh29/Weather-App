import 'package:flutter_application_1/data/data_provider/weather_api.dart';
import 'package:flutter_application_1/data/models/local_data.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';

class WeatherRepository {
  WeatherAPI? weatherAPI = WeatherAPI();
  Future<WeatherInfor?> getWeatherInforForLocation(String city) async {
    final data = await weatherAPI!.getRawWeather(city);
    print(data.runtimeType);
    if (data != null) {
      final WeatherInfor weatherInfor = WeatherInfor.fromJson(data);
      return weatherInfor;
    }
  }

  Future<WeatherInfor?> getWeatherInforForLongLat(
      double longitude, double latitude) async {
    final data = await weatherAPI!.getWeatherFromLongLat(longitude, latitude);
    if (data != null) {
      final WeatherInfor weatherInfor = WeatherInfor.fromJson(data);
      return weatherInfor;
    }
  }

  Future<List<WeatherInfor>?> getListWeatherInforBasedOnListLocation(
      List<String> cities) async {
    List<WeatherInfor> list = [];
    for (var city in cities) {
      WeatherInfor? weatherInfor = await getWeatherInforForLocation(city);
      if (weatherInfor != null) {
        list.add(weatherInfor);
      }
    }
    return list;
  }

  Future<List<WeatherInfor>?> getListWeatherInforBaseOnSearchKey(
      String searchKey) async {
    List<WeatherInfor> list = [];
  }

  // Future<List<WeatherInfor>?>  getListWeatherInforBasedOnListLongLat(List<>)async{
  //   List<WeatherInfor> list = [];
  //   for (var city in cities) {
  //     WeatherInfor? weatherInfor = await getWeatherInforForLocation(city);
  //     if (weatherInfor != null) {
  //       list.add(weatherInfor);
  //     }
  //   }
  //   return list;
  // }
}
