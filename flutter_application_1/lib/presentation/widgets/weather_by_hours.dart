import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_provider/methods.dart';
import 'package:flutter_application_1/data/models/forecast_hour.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/common/utils/helpers/patterns.dart';
import 'package:intl/intl.dart';

class WeatherByHours extends StatelessWidget {
  WeatherByHours({super.key, required this.weatherInfor});
  WeatherInfor weatherInfor;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<ForecastDataHour> list = CommondMethods.getDataHours(
        weatherInfor.forecast!.first.hours!,
        Patterns.getDateTimeToHourByString(weatherInfor.location!.localTime!));

    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            // Text("Today ${DateFormat.yMd().format(DateTime.now())}"),
            // const SizedBox(
            //   height: 3,
            // ),
            Container(
              height: size.height * 0.15,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AnHourCard(
                      data: list[index],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 4,
                      ),
                  itemCount: list.length),
            ),
          ],
        ),
      ),
    );
  }
}

class AnHourCard extends StatelessWidget {
  AnHourCard({super.key, required this.data});
  ForecastDataHour data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // boxShadow: const [
        //   BoxShadow(
        //       color: Colors.black12, offset: Offset(6, 6), blurRadius: 12.5),
        // ],
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
      ),
      height: size.height * 0.13,
      width: size.width * 0.18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(Patterns.convertTimeToHourAndMinute(data.time!)),
          Container(
            width: 40,
            height: 40,
            child: Image.network(
              "https:${data.conditionIcon}",
              fit: BoxFit.cover,
            ),
          ),
          Text("${data.temp_c}\u2103"),
        ],
      ),
    );
  }
}
