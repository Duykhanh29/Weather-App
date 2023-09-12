// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  final double? latitude;
  final double? longitude;
  final String? country;
  final String? region;
  final String? name;
  final String? localTime;
  Location(
      {this.country,
      this.latitude,
      this.localTime,
      this.longitude,
      this.name,
      this.region});

  Map<String, dynamic> toJson() => _$LocationToJson(this);
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [latitude, localTime, longitude, country, name, region];
}
