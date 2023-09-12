// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'air_quality.g.dart';

@JsonSerializable()
class AirQuality extends Equatable {
  final double? co;
  final double? o3;
  final int? index;
  AirQuality({
    this.index,
    this.co,
    this.o3,
  });

  Map<String, dynamic> toJson() => _$AirQualityToJson(this);

  factory AirQuality.fromJson(Map<String, dynamic> json) =>
      _$AirQualityFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [co, o3, index];
}
