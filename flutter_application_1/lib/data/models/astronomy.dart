// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'astronomy.g.dart';

@JsonSerializable()
class Astronomy extends Equatable {
  final String? sunrise;
  final String? sunset;
  final String? moonrise;
  final String? moonset;
  Astronomy({this.moonrise, this.moonset, this.sunrise, this.sunset});
  factory Astronomy.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [sunrise, sunset, moonrise, moonset];
}
