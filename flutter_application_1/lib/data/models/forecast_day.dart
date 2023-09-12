// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/astronomy.dart';
import 'package:flutter_application_1/data/models/forecast_hour.dart';
import 'package:json_annotation/json_annotation.dart';
part 'forecast_day.g.dart';

@JsonSerializable(explicitToJson: true)
class ForecastDay extends Equatable {
  final String? date;
  final double? avgtemp_c;
  final double? mintemp_c;
  final double? maxtemp_c;
  final double? maxwind_mph;
  final int? avghumidity;
  final String? conditionIcon;
  final String? conditionText;
  final double? uv;
  final List<ForecastDataHour>? hours;
  final Astronomy? astro;
  ForecastDay({
    this.uv,
    this.maxwind_mph,
    this.astro,
    this.conditionIcon,
    this.conditionText,
    this.date,
    this.avgtemp_c,
    this.mintemp_c,
    this.maxtemp_c,
    this.avghumidity,
    this.hours,
  });

  Map<String, dynamic> toJson() => _$ForecastDayToJson(this);

  factory ForecastDay.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [
        date,
        avgtemp_c,
        mintemp_c,
        maxtemp_c,
        maxwind_mph,
        avghumidity,
        conditionIcon,
        conditionText,
        uv,
        hours,
        astro
      ];
}
