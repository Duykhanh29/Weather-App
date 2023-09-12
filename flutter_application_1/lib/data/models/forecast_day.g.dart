// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDay _$ForecastDayFromJson(Map<String, dynamic> json) => ForecastDay(
      uv: (json['day']['uv'] as num).toDouble(),
      maxwind_mph: (json['day']['maxwind_mph'] as num).toDouble(),
      astro: Astronomy.fromJson(json['astro']),
      conditionIcon: json['day']['condition'] == null
          ? null
          : json['day']['condition']['icon'],
      conditionText: json['day']['condition'] == null
          ? null
          : json['day']['condition']['icon'],
      date: json['date'] as String?,
      avgtemp_c: (json['day']['avgtemp_c'] as num?)?.toDouble(),
      mintemp_c: (json['day']['mintemp_c'] as num?)?.toDouble(),
      maxtemp_c: (json['day']['maxtemp_c'] as num?)?.toDouble(),
      avghumidity: (json['day']['avghumidity'] as num?)?.toInt(),
      hours: json['hour'] == null
          ? null
          : (json['hour'] as List<dynamic>?)
              ?.map((e) => ForecastDataHour.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ForecastDayToJson(ForecastDay instance) {
  final Map<String, dynamic> data = <String, dynamic>{
    'date': instance.date,
    'hour': instance.hours?.map((e) => e.toJson()).toList(),
    'astro': instance.astro,
  };
  final Map<String, dynamic> conditionData = <String, dynamic>{
    'icon': instance.conditionIcon,
    'text': instance.conditionText
  };
  final Map<String, dynamic> dayData = <String, dynamic>{
    'condition': conditionData,
    'avgtemp_c': instance.avgtemp_c,
    'mintemp_c': instance.mintemp_c,
    'maxtemp_c': instance.maxtemp_c,
    'avghumidity': instance.avghumidity,
    'maxwind_mph': instance.maxwind_mph,
    'uv': instance.uv
  };
  data['day'] = dayData;
  return data;
}
