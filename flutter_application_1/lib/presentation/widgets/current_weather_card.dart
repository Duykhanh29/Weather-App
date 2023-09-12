import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/presentation/pages/detailed_weather_page.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentWeatherCard extends StatelessWidget {
  CurrentWeatherCard({super.key, required this.weatherInfor});
  WeatherInfor weatherInfor;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailPage(
            weatherInfor: weatherInfor,
            isCurrentWeather: true,
          );
        }));
      },
      child: Container(
        // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
        padding: const EdgeInsets.all(5),
        width: size.width,
        height: size.height * 0.25,
        child:
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            Container(
          // margin: const EdgeInsets.fromLTRB(3, 3, 3, 3),
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          width: size.width * 0.9,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment(-1, -1),
              end: Alignment(1, 1),
              colors: <Color>[
                Color(0xff3c6fd1),
                Color(0xff3c6fd1),
                Color(0xff7ca8ff)
              ],
              stops: <double>[0, 0, 1],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x19363b64),
                offset: Offset(5, 6),
                blurRadius: 12.5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            constraints:
                                BoxConstraints(maxWidth: size.width * 0.6),
                            child: Text(
                              weatherInfor.currentWeather!.conditionText!,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              " ${weatherInfor.currentWeather!.temp_c}"
                              "\u2103",
                              style: GoogleFonts.aclonica(
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        "https:${weatherInfor.currentWeather!.conditionIcon!}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/humidity.png",
                            height: 16, width: 16),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${weatherInfor.currentWeather!.humidity!}"
                          " \u0025",
                          style: GoogleFonts.adventPro(
                            fontSize: 20,
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/wind.png",
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${weatherInfor.currentWeather!.wind_mph!} mp/h",
                          style: GoogleFonts.adventPro(
                            fontSize: 20,
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/UV.jpg",
                            height: 23, width: 23),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "${weatherInfor.currentWeather!.uv!}",
                          style: GoogleFonts.adventPro(
                            fontSize: 20,
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\u2601'),
                        // Icon(Icons.cloud),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${weatherInfor.currentWeather!.cloud!} \u0025",
                          style: GoogleFonts.adventPro(
                            fontSize: 20,
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
