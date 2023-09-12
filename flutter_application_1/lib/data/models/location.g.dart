// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      country: json['country'] as String?,
      latitude: (json['lat'] as num?)?.toDouble(),
      localTime: json['localtime'] as String?,
      longitude: (json['lon'] as num?)?.toDouble(),
      name: json['name'] as String?,
      region: json['region'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.latitude,
      'lon': instance.longitude,
      'country': instance.country,
      'region': instance.region,
      'name': instance.name,
      'localTime': instance.localTime,
    };
