// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_application_1/data/models/air_quality.dart';
import 'package:flutter_application_1/data/models/current_weather.dart';
import 'package:flutter_application_1/data/models/forecast_day.dart';
import 'package:flutter_application_1/data/models/forecast_hour.dart';
import 'package:flutter_application_1/data/models/location.dart';

part 'weather_infor.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherInfor extends Equatable {
  final Location? location;
  final List<ForecastDay>? forecast;
  final CurrentWeather? currentWeather;
  WeatherInfor({
    this.location,
    this.forecast,
    this.currentWeather,
  });

  Map<String, dynamic> toJson() => _$WeatherInforToJson(this);

  factory WeatherInfor.fromJson(Map<String, dynamic> json) =>
      _$WeatherInforFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [location, forecast, currentWeather];
}
