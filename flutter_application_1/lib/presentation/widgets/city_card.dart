import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/data/data_provider/sqlite_db.dart';
import 'package:flutter_application_1/data/models/local_data.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/logic/list_interested_city.dart/interested_cities_bloc.dart';
import 'package:flutter_application_1/logic/list_weather/list_weather_bloc.dart';
import 'package:flutter_application_1/presentation/pages/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityCard extends StatelessWidget {
  CityCard({super.key, required this.weatherInfor});
  WeatherInfor weatherInfor;
  // bool checkExisted(List<WeatherInfor>? listWeatherInfor,)
  final SQLiteDatabase sqLiteDatabase = SQLiteDatabase();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MainScreen(
              weatherRepo:
                  BlocProvider.of<ListWeatherBloc>(context).weatherRepository,
              city: weatherInfor.location!.name);
        }));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: size.height * 0.13,
          color: const Color.fromARGB(255, 140, 177, 182),
          child: Center(
            child: ListTile(
              leading: Text("${weatherInfor.currentWeather!.temp_c}" "\u2103"),
              title: Text(weatherInfor.location!.name!),
              subtitle: Text(weatherInfor.location!.country!),
              trailing:
                  // IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                  BlocBuilder<InterestedCitiesBloc, InterestedCitiesState>(
                builder: (context, state) {
                  if (state is InterestedCitiesFetched) {
                    final isInCart =
                        state.listWeatherInfor!.contains(weatherInfor);
                    return Builder(
                      builder: (contextBuild) => IconButton(
                          onPressed: () async {
                            if (!isInCart) {
                              BlocProvider.of<InterestedCitiesBloc>(
                                      contextBuild)
                                  .add(InterestedCitiesAdded(
                                      weatherInfor.location!));
                            } else {
                              contextBuild.read<InterestedCitiesBloc>().add(
                                  InterestedCitiesRemoved(
                                      weatherInfor.location!));
                            }
                          },
                          icon: !isInCart
                              ? const Icon(Icons.add)
                              : const Icon(Icons.remove)),
                    );
                  } else if (state is InterestedEmptyCities) {
                    return Builder(
                      builder: (contextBuild) {
                        return IconButton(
                            onPressed: () async {
                              BlocProvider.of<InterestedCitiesBloc>(
                                      contextBuild)
                                  .add(InterestedCitiesAdded(
                                      weatherInfor.location!));
                            },
                            icon: const Icon(Icons.add));
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
