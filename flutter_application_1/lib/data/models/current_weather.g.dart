// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      conditionIcon: json['condition']['icon'] as String?,
      conditionText: json['condition']['text'] as String?,
      lastUpdate: json['last_updated'] as String?,
      temp_c: (json['temp_c'] as num?)?.toDouble(),
      uv: (json['uv'] as num?)?.toDouble(),
      isDay: json['is_day'] as int?,
      humidity: json['humidity'] as int?,
      cloud: json['cloud'] as int?,
      wind_mph: (json['wind_mph'] as num?)?.toDouble(),
      airQuality: json['air_quality'] == null
          ? null
          : AirQuality.fromJson(json['air_quality'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) {
  final Map<String, dynamic> data = <String, dynamic>{
    'last_updated': instance.lastUpdate,
    'temp_c': instance.temp_c,
    'uv': instance.uv,
    'is_day': instance.isDay,
    'humidity': instance.humidity,
    'cloud': instance.cloud,
    'wind_mph': instance.wind_mph,
    'air_quality': instance.airQuality?.toJson(),
  };
  final Map<String, dynamic> conditionData = <String, dynamic>{
    'icon': instance.conditionIcon,
    'text': instance.conditionText,
  };
  data['condition'] = conditionData;
  return data;
}
