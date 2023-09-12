// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast_hour.g.dart';

@JsonSerializable()
class ForecastDataHour extends Equatable {
  final String? time;
  final double? temp_c;
  final String? conditionIcon;
  final String? conditionText;
  final double? wind_mph;
  final int? cloud;
  final int? humidity;
  final double? uv;
  ForecastDataHour(
      {this.time,
      this.temp_c,
      this.conditionIcon,
      this.conditionText,
      this.wind_mph,
      this.cloud,
      this.humidity,
      this.uv});

  Map<String, dynamic> toJson() => _$ForecastDataHourToJson(this);

  factory ForecastDataHour.fromJson(Map<String, dynamic> json) =>
      _$ForecastDataHourFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [
        time,
        temp_c,
        conditionIcon,
        conditionText,
        wind_mph,
        cloud,
        humidity,
        uv
      ];
}
