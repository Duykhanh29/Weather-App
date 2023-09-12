import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:google_fonts/google_fonts.dart';

class UVIndexWidget extends StatelessWidget {
  UVIndexWidget(
      {super.key,
      required this.weatherInfor,
      required this.isCurrentWeather,
      this.forecastIndex});
  WeatherInfor weatherInfor;
  bool isCurrentWeather;
  int? forecastIndex;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.lightBlue.shade100,
        height: size.height * 0.08,
        width: size.width * 0.38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/UV.jpg",
              width: 30,
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    isCurrentWeather
                        ? "${weatherInfor.currentWeather!.uv}"
                        : "${weatherInfor.forecast![forecastIndex!].uv}",
                    style: GoogleFonts.alfaSlabOne(fontSize: 15)),
                Text(
                  "UV index",
                  style: GoogleFonts.alegreya(
                      fontSize: 15, fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
