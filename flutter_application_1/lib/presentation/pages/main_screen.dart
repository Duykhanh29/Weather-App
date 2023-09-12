import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';
import 'package:flutter_application_1/presentation/pages/main_widget.dart';
import 'package:flutter_application_1/presentation/widgets/current_weather_card.dart';
import 'package:flutter_application_1/presentation/widgets/forecast_weather_widget.dart';
import 'package:flutter_application_1/presentation/widgets/weather_by_hours.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(
      {super.key,
      required this.weatherRepo,
      this.latitude,
      this.longitude,
      required this.city});
  final double? longitude;
  final double? latitude;
  final WeatherRepository weatherRepo;
  final String? city;
  @override
  Widget build(BuildContext context) {
    final WeatherRepository weatherRepo = WeatherRepository();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.location_on)),
            Text(city!)
          ],
        ),
      ),
      body: MainWidget(
        weatherRepo: weatherRepo,
        city: city,
      ),
    );
  }
}
