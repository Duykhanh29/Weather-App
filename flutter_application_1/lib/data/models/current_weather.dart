// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'air_quality.dart';
part 'current_weather.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrentWeather extends Equatable {
  final String? lastUpdate; //
  final double? temp_c;
  final double? uv; //
  final int? isDay;
  final int? humidity;
  final int? cloud;
  final String? conditionText;
  final String? conditionIcon;
  final double? wind_mph;
  AirQuality? airQuality; //
  CurrentWeather(
      {this.lastUpdate,
      this.temp_c,
      this.conditionText,
      this.conditionIcon,
      this.uv,
      this.isDay,
      this.humidity,
      this.cloud,
      this.wind_mph,
      this.airQuality});

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [
        lastUpdate,
        cloud,
        airQuality,
        wind_mph,
        humidity,
        uv,
        isDay,
        temp_c,
        conditionText,
        conditionIcon
      ];
}
