import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/data/data_provider/methods.dart';
import 'package:flutter_application_1/data/models/forecast_day.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/presentation/widgets/cloud_detail.dart';
import 'package:flutter_application_1/presentation/widgets/humidity_widget.dart';
import 'package:flutter_application_1/presentation/widgets/uv_index.dart';
import 'package:flutter_application_1/presentation/widgets/wind_speed.dart';
import 'package:flutter_application_1/common/utils/helpers/patterns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetailPage extends StatelessWidget {
  DetailPage(
      {super.key,
      required this.weatherInfor,
      required this.isCurrentWeather,
      this.forecastIndex});
  WeatherInfor weatherInfor;
  bool isCurrentWeather;
  int? forecastIndex;
  Color getColorBasedOnPercentage(double percentage) {
    if (percentage >= 0.7) {
      return Colors.red;
    } else if (percentage >= 0.4) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ForecastDay? forecastDay;
    DateTime? date;
    if (!isCurrentWeather) {
      forecastDay = weatherInfor.forecast![forecastIndex!];
      date = Patterns.getDateTimeByString(forecastDay.date!);
    } else {
      date = Patterns.getDateTimeByString(
          weatherInfor.currentWeather!.lastUpdate!);
    }

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //       icon: const Icon(Icons.arrow_back_ios_new)),
      //   title: Text("City"),
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Stack(
            children: [
              Container(
                height: size.height,
                color: Colors.blueAccent.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        weatherInfor.location!.name!,
                        style: GoogleFonts.adventPro(
                            fontSize: 40, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        weatherInfor.location!.country!,
                        style: GoogleFonts.abyssinicaSil(
                            fontSize: 30, fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(
                          isCurrentWeather
                              ? "https:${weatherInfor.currentWeather!.conditionIcon}"
                              : "https:${weatherInfor.forecast![forecastIndex!].conditionIcon}",
                          width: 110,
                          height: 110,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isCurrentWeather
                                  ? "${weatherInfor.currentWeather!.temp_c!}"
                                  : "Average: ${weatherInfor.forecast![forecastIndex!].avgtemp_c!}"
                                      "\u2103",
                              style: GoogleFonts.abrilFatface(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.6),
                              child: Text(
                                weatherInfor.currentWeather!.conditionText!,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.adamina(
                                    fontSize: 26, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.height * 0.045,
                left: 0,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              )
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  height: double.infinity,
                  // child: SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, bottom: 15, top: 0),
                        child: Text(isCurrentWeather
                            ? "Updated at: ${DateFormat.j().format(date!)}"
                            : DateFormat.yMEd().format(date!)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: Text(
                          "Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                      if (!isCurrentWeather) ...{
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 13,
                            right: 13,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Min temperature: ${weatherInfor.forecast![forecastIndex!].mintemp_c!}"
                                "\u2103",
                                style: GoogleFonts.adamina(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                "Max temperature: ${weatherInfor.forecast![forecastIndex!].maxtemp_c!}"
                                "\u2103",
                                style: GoogleFonts.adamina(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      },
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (isCurrentWeather) ...{
                                CloudDetails(
                                  weatherInfor: weatherInfor,
                                ),
                              },
                              WindSpeedWidget(
                                isCurrentWeather: isCurrentWeather,
                                forecastIndex: forecastIndex,
                                weatherInfor: weatherInfor,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              UVIndexWidget(
                                isCurrentWeather: isCurrentWeather,
                                forecastIndex: forecastIndex,
                                weatherInfor: weatherInfor,
                              ),
                              HumidityWidget(
                                isCurrentWeather: isCurrentWeather,
                                forecastIndex: forecastIndex,
                                weatherInfor: weatherInfor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isCurrentWeather) ...{
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            color: Colors.blueGrey.shade200,
                            height: size.height * 0.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Air quality",
                                  style: GoogleFonts.aguafinaScript(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                    "${weatherInfor.currentWeather!.airQuality!.index}/10 (UK Defra Index)",
                                    style: GoogleFonts.adamina(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200)),
                                Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      semanticsLabel: weatherInfor
                                          .currentWeather!.airQuality!.index!
                                          .toString(),
                                      semanticsValue: weatherInfor
                                          .currentWeather!.airQuality!.index!
                                          .toString(),
                                      value: weatherInfor.currentWeather!
                                              .airQuality!.index! /
                                          10, // Giá trị tỷ lệ phần trăm
                                      backgroundColor:
                                          Colors.grey, // Màu nền của thanh bar
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          getColorBasedOnPercentage(weatherInfor
                                                  .currentWeather!
                                                  .airQuality!
                                                  .index! /
                                              10)), // Màu của thanh bar
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      left: 0,
                                      bottom: 0,
                                      child: Text(
                                        weatherInfor
                                            .currentWeather!.airQuality!.index!
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black, // Màu chữ
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                    CommondMethods.showBandFromAirQualityIndex(
                                        weatherInfor.currentWeather!.airQuality!
                                            .index!),
                                    style: GoogleFonts.adamina(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      },
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.blueGrey.shade200,
                          height: size.height * 0.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sun",
                                style: GoogleFonts.allura(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          weatherInfor
                                              .forecast!.first.astro!.sunrise!,
                                          style: GoogleFonts.adamina(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text("Sunrise")
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/sun.jpg",
                                    width: 40,
                                    height: 40,
                                  ),
                                  FittedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          weatherInfor
                                              .forecast!.first.astro!.sunset!,
                                          style: GoogleFonts.adamina(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text("Sunset")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.blueGrey.shade200,
                          height: size.height * 0.1,
                          width: size.width * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Moon",
                                style: GoogleFonts.allura(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FittedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          weatherInfor
                                              .forecast!.first.astro!.moonrise!,
                                          style: GoogleFonts.adamina(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text("Moonrise")
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/moon.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                  FittedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          weatherInfor
                                              .forecast!.first.astro!.moonset!,
                                          style: GoogleFonts.adamina(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text("Moonset")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HumidityCircularSlider(
                          value: isCurrentWeather
                              ? weatherInfor.currentWeather!.humidity!
                              : weatherInfor
                                  .forecast![forecastIndex!].avghumidity!),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isCurrentWeather) ...{
                        CloudCircularSlider(
                            value: weatherInfor.currentWeather!.cloud!)
                      },
                    ],
                  ),
                ),
                // ),
              );
            },
          )
        ],
      ),
    );
  }
}

class HumidityCircularSlider extends StatelessWidget {
  HumidityCircularSlider({super.key, required this.value});
  int value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Humidity level"),
            const SizedBox(
              height: 5,
            ),
            SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: value.toDouble(),
              appearance: CircularSliderAppearance(
                  infoProperties: InfoProperties(
                      // topLabelText: "Oke",
                      // topLabelStyle: TextStyle(
                      //   letterSpacing: 0.1,
                      //   fontSize: 14,
                      //   height: 1.4,
                      // ),
                      bottomLabelStyle: const TextStyle(
                        letterSpacing: 0.1,
                        fontSize: 14,
                        height: 1.4,
                      ),
                      bottomLabelText: "Humidity"),
                  animationEnabled: true,
                  customColors: CustomSliderColors(
                      hideShadow: true,
                      trackColor: Colors.blueAccent,
                      progressBarColors: [
                        Colors.amberAccent,
                        Colors.greenAccent
                      ])),
            )
          ],
        ),
      ),
    );
  }
}

class CloudCircularSlider extends StatelessWidget {
  CloudCircularSlider({super.key, required this.value});
  int value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Cloud level"),
            const SizedBox(
              height: 5,
            ),
            SleekCircularSlider(
              initialValue: value.toDouble(),
              min: 0,
              max: 100,
              appearance: CircularSliderAppearance(
                  animationEnabled: true,
                  infoProperties: InfoProperties(
                      // topLabelText: "Oke",
                      // topLabelStyle: TextStyle(
                      //   letterSpacing: 0.1,
                      //   fontSize: 14,
                      //   height: 1.4,
                      // ),
                      bottomLabelStyle: const TextStyle(
                        letterSpacing: 0.1,
                        fontSize: 14,
                        height: 1.4,
                      ),
                      bottomLabelText: "Humidity"),
                  customColors: CustomSliderColors(
                      hideShadow: true,
                      trackColor: Colors.green,
                      progressBarColors: [
                        Colors.orangeAccent,
                        Colors.pinkAccent
                      ])),
            )
          ],
        ),
      ),
    );
  }
}
