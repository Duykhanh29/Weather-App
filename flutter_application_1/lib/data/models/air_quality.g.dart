// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirQuality _$AirQualityFromJson(Map<String, dynamic> json) => AirQuality(
    co: (json['co'] as num?)?.toDouble(),
    o3: (json['o3'] as num?)?.toDouble(),
    index: (json['gb-defra-index'] as num).toInt());

Map<String, dynamic> _$AirQualityToJson(AirQuality instance) =>
    <String, dynamic>{
      'co': instance.co,
      'o3': instance.o3,
      'gb-defra-index': instance.index
    };
