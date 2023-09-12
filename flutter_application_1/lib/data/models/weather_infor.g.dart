// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherInfor _$WeatherInforFromJson(Map<String, dynamic> json) => WeatherInfor(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      // forecastDay: json['forecastDataHour'] == null
      //     ? null
      //     : ForecastDataHour.fromJson(
      //         json['forecastDataHour'] as Map<String, dynamic>),
      forecast: json['forecast'] == null
          ? null
          : (json['forecast']['forecastday'] as List<dynamic>)
              .map((e) => ForecastDay.fromJson(e as Map<String, dynamic>))
              .toList(),
      currentWeather: json['current'] == null
          ? null
          : CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherInforToJson(WeatherInfor instance) =>
    <String, dynamic>{
      'location': instance.location?.toJson(),
      'forecast': instance.forecast?.map((e) => e.toJson()).toList(),
      'current': instance.currentWeather?.toJson(),
    };
