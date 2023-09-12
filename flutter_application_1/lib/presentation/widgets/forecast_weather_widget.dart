import 'dart:ui';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_provider/methods.dart';
import 'package:flutter_application_1/data/models/current_weather.dart';
import 'package:flutter_application_1/data/models/forecast_day.dart';
import 'package:flutter_application_1/data/models/forecast_hour.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/presentation/pages/detailed_weather_page.dart';
import 'package:flutter_application_1/common/utils/helpers/check_methods.dart';
import 'package:flutter_application_1/common/utils/helpers/patterns.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ForecastWeatherWidget extends StatelessWidget {
  ForecastWeatherWidget({super.key, required this.weatherInfor});
  WeatherInfor weatherInfor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // gradient: const LinearGradient(
          //   begin: Alignment(-1, -1),
          //   end: Alignment(1, 1),
          //   colors: <Color>[
          //     Color(0xff3c6fd1),
          //     Color(0xff3c6fd1),
          //     Color(0xff7ca8ff)
          //   ],
          //   stops: <double>[0, 0, 1],
          // ),
          color: Colors.blueAccent.shade100),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 150,
              height: 30,
              child: Center(
                  child: Text(
                "7 days Forecast",
                style: GoogleFonts.adamina(fontSize: 16),
              ))),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DetailPage(
                          weatherInfor: weatherInfor,
                          isCurrentWeather: false,
                          forecastIndex: index,
                        );
                      }));
                    },
                    child: ForecastDayCard(
                      currentWeather: weatherInfor.currentWeather!,
                      forecastDay: weatherInfor.forecast![index],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                itemCount: weatherInfor.forecast!.length),
          ),
        ],
      ),
    );
  }
}

class ForecastDayCard extends StatelessWidget {
  ForecastDayCard(
      {super.key, required this.forecastDay, required this.currentWeather});
  ForecastDay forecastDay;
  CurrentWeather currentWeather;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime date = DateFormat("yyyy-MM-dd").parse(forecastDay.date!);
    return
        // GestureDetector(
        //   onTap: () {
        //     // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //     //   return DetailPage(
        //     //     weatherInfor: weatherInfor,
        //     //   );
        //     // }));
        //   },
        //   child:
        SizedBox(
      height: size.height * 0.075,
      child: ListTile(
        leading: forecastDay.conditionIcon == null
            ? Image.network(
                "https://scontent.fhan4-2.fna.fbcdn.net/v/t15.5256-10/361932136_184604547940409_7677319347018510863_n.jpg?stp=dst-jpg_p480x480&_nc_cat=111&ccb=1-7&_nc_sid=ad6a45&_nc_ohc=AEsRuKpJlSQAX8PPZ4Q&_nc_ht=scontent.fhan4-2.fna&oh=00_AfDICyoqN2s6AajdzZRXBdYweCJvNMNi9jIAbdNrs8nGmw&oe=64F68CC6")
            : Image.network("https:${forecastDay.conditionIcon}"),
        title: CheckMethod.isSameDay(forecastDay.date!)
            ? const Text("Today")
            : Text(DateFormat.EEEE().format(date)),
        trailing: CheckMethod.isSameDay(forecastDay.date!)
            ? Text("${currentWeather.temp_c} " "\u2103")
            : Text("${forecastDay.mintemp_c}"
                "\u2103 / ${forecastDay.mintemp_c}"
                "\u2103"),
      ),
      // ),
    );
  }
}
