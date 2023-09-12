import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class LocalData extends Equatable {
  final String city;
  final int id;
  final double longitude;
  final double latitude;
  LocalData(this.city, this.id, this.latitude, this.longitude);
  Map<String, dynamic> toJson() =>
      {"city": city, "longitude": longitude, "latitude": latitude, "id": id};
  factory LocalData.fromJson(Map<String, dynamic> json) {
    return LocalData(
        json['city'], json['id'], json['latitude'], json['longitude']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [city, id, latitude, latitude];
}
