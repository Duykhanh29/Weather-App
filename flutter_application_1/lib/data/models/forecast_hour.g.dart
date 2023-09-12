// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_hour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDataHour _$ForecastDataHourFromJson(Map<String, dynamic> json) =>
    ForecastDataHour(
      time: json['time'] as String?,
      temp_c: (json['temp_c'] as num?)?.toDouble(),
      conditionIcon: json['condition']['icon'] as String?,
      conditionText: json['condition']['text'] as String?,
      wind_mph: (json['wind_mph'] as num?)?.toDouble(),
      cloud: json['cloud'] as int?,
      humidity: json['humidity'] as int?,
      uv: json['uv'] as double?,
    );

Map<String, dynamic> _$ForecastDataHourToJson(ForecastDataHour instance) {
  final Map<String, dynamic> data = <String, dynamic>{
    'time': instance.time,
    'temp_c': instance.temp_c,
    'wind_mph': instance.wind_mph,
    'cloud': instance.cloud,
    'humidity': instance.humidity,
    'uv': instance.uv,
  };
  // Tạo một đối tượng condition chứa conditionIcon và conditionText
  final Map<String, dynamic> conditionData = <String, dynamic>{
    'icon': instance.conditionIcon,
    'text': instance.conditionText,
  };
  // Đưa đối tượng condition vào data
  data['condition'] = conditionData;

  return data;
}
