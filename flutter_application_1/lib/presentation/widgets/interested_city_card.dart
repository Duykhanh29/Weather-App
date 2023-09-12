import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';
import 'package:flutter_application_1/logic/list_interested_city.dart/interested_cities_bloc.dart';
import 'package:flutter_application_1/presentation/pages/main_screen.dart';
import 'package:flutter_application_1/presentation/widgets/current_weather_card.dart';
import 'package:flutter_application_1/presentation/widgets/forecast_weather_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestedCityCard extends StatelessWidget {
  const InterestedCityCard({super.key, required this.weatherInfor});
  final WeatherInfor weatherInfor;
  @override
  Widget build(BuildContext context) {
    print(weatherInfor);
    final size = MediaQuery.of(context).size;
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        BlocProvider.of<InterestedCitiesBloc>(context)
            .add(InterestedCitiesRemoved(weatherInfor.location!));
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure to delete?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
      },
      onResize: () {
        print("On resize");
      },
      onUpdate: (details) {
        print("onUpdate");
        print(details);
      },
      behavior: HitTestBehavior.opaque,
      dragStartBehavior: DragStartBehavior.start,
      movementDuration: const Duration(milliseconds: 200),
      crossAxisEndOffset: 0.0,
      resizeDuration: const Duration(milliseconds: 300),
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.2,
        DismissDirection.endToStart: 0.2,
      },
      background: Container(
        color: Colors.redAccent,
        child: const Icon(Icons.remove_circle),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MainScreen(
                weatherRepo: BlocProvider.of<InterestedCitiesBloc>(context)
                    .weatherRepository,
                city: weatherInfor.location!.name);
          }));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: size.height * 0.13,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.cyanAccent,
                    Colors.grey,
                    Colors.indigoAccent,
                  ],
                  begin: Alignment(-1, -1),
                  end: Alignment(1, 1),
                  stops: [0, 0, 1]),
            ),
            child: Center(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(weatherInfor.location!.name!),
                subtitle: Text(weatherInfor.currentWeather!.conditionText!),
                trailing: FittedBox(
                  child: Container(
                    color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(
                          "https:${weatherInfor.currentWeather!.conditionIcon!}",
                          height: 50,
                          width: 50,
                        ),
                        Text("${weatherInfor.currentWeather!.temp_c}" "\u2103")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
