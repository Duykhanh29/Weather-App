import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:google_fonts/google_fonts.dart';

class CloudDetails extends StatelessWidget {
  CloudDetails({super.key, required this.weatherInfor});
  WeatherInfor weatherInfor;
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
              "assets/images/cloud.png",
              width: 30,
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${weatherInfor.currentWeather!.cloud!}" "\u0025",
                    style: GoogleFonts.alfaSlabOne(fontSize: 15)),
                Text(
                  "Cloud",
                  style: GoogleFonts.alegreya(
                      fontSize: 20, fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
