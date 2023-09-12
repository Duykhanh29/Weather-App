import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_provider/sqlite_db.dart';
import 'package:flutter_application_1/data/models/local_data.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';
import 'package:flutter_application_1/logic/list_interested_city.dart/interested_cities_bloc.dart';
import 'package:flutter_application_1/logic/list_weather/list_weather_bloc.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/presentation/pages/main_widget.dart';
import 'package:flutter_application_1/presentation/pages/main_screen.dart';
import 'package:flutter_application_1/presentation/widgets/city_card.dart';
import 'package:flutter_application_1/presentation/widgets/interested_city_card.dart';
import 'package:flutter_application_1/presentation/widgets/current_weather_card.dart';
import 'package:flutter_application_1/presentation/widgets/forecast_weather_widget.dart';
import 'package:flutter_application_1/presentation/widgets/weather_by_hours.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCity extends StatefulWidget {
  ListCity({super.key});

  @override
  State<ListCity> createState() => _ListCityState();
}

class _ListCityState extends State<ListCity> {
  final SQLiteDatabase sqLiteDatabase = SQLiteDatabase();

  List<LocalData>? listLocalData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setData();
  }

  Future setData() async {
    // await sqLiteDatabase.database;
    listLocalData = await sqLiteDatabase.fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    // final WeatherRepository weatherRepo = WeatherRepository();
    return Expanded(
      child: Builder(
        builder: (contexBuild) =>
            BlocBuilder<ListWeatherBloc, ListWeatherState>(
          builder: (contexBuild, state) {
            if (state is ListWeatherInitial) {
              return BlocBuilder<InterestedCitiesBloc, InterestedCitiesState>(
                builder: (context, state) {
                  if (state is InterestedCitiesInitial) {
                    return const Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    );
                  } else if (state is InterestedCitiesFetched) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const RangeMaintainingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InterestedCityCard(
                              weatherInfor: state.listWeatherInfor![index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 4,
                            ),
                        itemCount: state.listWeatherInfor != null
                            ? state.listWeatherInfor!.length
                            : 0);
                  } else if (state is InterestedEmptyCities) {
                    return const Center(
                      child: Text("Empty city"),
                    );
                  } else {
                    return const Center(
                      child: Text("Something went "),
                    );
                  }
                },
              );
              // return Text("data");
            } else if (state is ListWeatherFetched) {
              if (state.listWeatherInfor == null) {
                return const Center(
                  child: Text("No city"),
                );
              } else {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const RangeMaintainingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CityCard(
                        weatherInfor: state.listWeatherInfor![index],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 4,
                        ),
                    itemCount: state.listWeatherInfor != null
                        ? state.listWeatherInfor!.length
                        : 0);
              }
            } else if (state is ListWeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Something went wrong 1"),
              );
            }
          },
        ),
      ),
    );
  }
}
