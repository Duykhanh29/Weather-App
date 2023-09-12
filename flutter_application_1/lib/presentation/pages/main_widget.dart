import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';
import 'package:flutter_application_1/presentation/widgets/current_weather_card.dart';
import 'package:flutter_application_1/presentation/widgets/forecast_weather_widget.dart';
import 'package:flutter_application_1/presentation/widgets/weather_by_hours.dart';

class MainWidget extends StatelessWidget {
  const MainWidget(
      {super.key,
      required this.weatherRepo,
      this.city,
      this.latitude,
      this.longitude});

  final WeatherRepository weatherRepo;
  final String? city;
  final double? longitude;
  final double? latitude;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                print(snapshot.data!.currentWeather!.airQuality!.co!);
                // print((snapshot.data!.forecast)!.last.avghumidity);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      CurrentWeatherCard(weatherInfor: snapshot.data!),
                      const SizedBox(
                        height: 5,
                      ),
                      WeatherByHours(
                        weatherInfor: snapshot.data!,
                      ),
                      ForecastWeatherWidget(
                        weatherInfor: snapshot.data!,
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('data null'),
                );
              }
            } else {
              return const Center(
                child: Text('hasData null'),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('ConnectionState.none'),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            return const Center(
              child: Text('ConnectionState.active'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: city != null
            ? weatherRepo.getWeatherInforForLocation(city!)
            : weatherRepo.getWeatherInforForLongLat(longitude!, latitude!),
      ),
    );
  }
}
