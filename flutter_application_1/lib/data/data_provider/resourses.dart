import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class Resource {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<String?> getCityFromCoordinates(
      double latitude, double longitude) async {
    final apiKey = 'e2707be14e4f420e83543d1c134debfc';
    final apiUrl =
        'https://api.opencagedata.com/geocode/v1/json?key=$apiKey&q=$latitude,$longitude';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final city = data['results'][0]['components']['county'];
      return city;
    } else {
      throw Exception('Failed to get city from coordinates');
    }
  }

  static Future<String?> getCityName(double latitude, double longitude) async {
    final apiKey =
        'AIzaSyCs9W9bINqez--VJtrVyMZUVh1eXG8d78c'; // Thay YOUR_API_KEY_HERE bằng API key của bạn

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Kiểm tra xem có kết quả không
      if (data['status'] == 'OK') {
        final results = data['results'][0]['address_components'];

        // Tìm tên thành phố trong kết quả
        for (var result in results) {
          final types = result['types'];
          if (types.contains('locality')) {
            return result['long_name'];
          }
        }
      }
    }
  }

  static Future<String> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    return place.locality!;
  }
}
