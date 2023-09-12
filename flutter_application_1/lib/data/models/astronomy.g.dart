// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astronomy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Astronomy _$CurrentWeatherFromJson(Map<String, dynamic> json) => Astronomy(
      moonrise: json['moonrise'] as String?,
      moonset: json['moonset'] as String?,
      sunrise: json['sunrise'] as String?,
      sunset: json['sunset'] as String?,
    );

Map<String, dynamic> _$CurrentWeatherToJson(Astronomy instance) {
  final Map<String, dynamic> data = <String, dynamic>{
    'moonset': instance.moonset,
    'moonrise': instance.moonrise,
    'sunrise': instance.sunrise,
    'sunset': instance.sunset
  };
  // final Map<String, dynamic> conditionData = <String, dynamic>{};
  // data['condition'] = conditionData;
  return data;
}
