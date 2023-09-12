import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/data_provider/sqlite_db.dart';
import 'package:flutter_application_1/data/models/local_data.dart';
import 'package:flutter_application_1/data/models/location.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'interested_cities_event.dart';
part 'interested_cities_state.dart';

class InterestedCitiesBloc
    extends Bloc<InterestedCitiesEvent, InterestedCitiesState> {
  InterestedCitiesBloc(
      {required this.sqLiteDatabase, required this.weatherRepository})
      : super(InterestedCitiesInitial()) {
    on<InterestedCitiesStarted>(onInterestedCitiesStarted);
    on<InterestedCitiesAdded>(onInterestedCitiesAdded);
    on<InterestedCitiesRemoved>(onInterestedCitiesRemoved);
  }
  final SQLiteDatabase sqLiteDatabase;
  final WeatherRepository weatherRepository;
  Future onInterestedCitiesStarted(InterestedCitiesStarted event,
      Emitter<InterestedCitiesState> emit) async {
    try {
      // List<String> listCityInLocal =
      //     await sqLiteDatabase.getListCityInLocalData(event.listLocalData);
      // Database database = await sqLiteDatabase.initilizeDB();
      // print(database);
      List<LocalData>? listLocalData = await sqLiteDatabase.fetchAllData();
      if (listLocalData != null) {
        List<String> listCities = listLocalData.map((e) => e.city).toList();
        List<WeatherInfor>? listData = await weatherRepository
            .getListWeatherInforBasedOnListLocation(listCities);
        if (listData != null) {
          if (listData.isNotEmpty) {
            emit(InterestedCitiesFetched(listData));
          } else {
            emit(InterestedEmptyCities());
          }
        } else {
          emit(InterestedCitiesError());
        }
      } else {
        emit(InterestedEmptyCities());
      }
    } catch (e) {
      print("Error: $e");
      emit(InterestedCitiesError());
    }
  }

  Future onInterestedCitiesAdded(
      InterestedCitiesAdded event, Emitter<InterestedCitiesState> emit) async {
    try {
      int result = await sqLiteDatabase.insertData(
          city: event.location.name!,
          latitude: event.location.latitude!,
          longitude: event.location.longitude!);
      if (result != 0) {
        List<LocalData>? listLocalData = await sqLiteDatabase.fetchAllData();
        if (listLocalData != null) {
          List<String> listCityInLocal =
              await sqLiteDatabase.getListCityInLocalData(listLocalData);
          List<WeatherInfor>? listWeatherInfor = await weatherRepository
              .getListWeatherInforBasedOnListLocation(listCityInLocal);
          emit(InterestedCitiesFetched(listWeatherInfor!));
        } else {
          emit(InterestedCitiesError());
        }
      }
    } catch (e) {
      print("An error occurred: $e");
      emit(InterestedCitiesError());
    }
  }

  Future onInterestedCitiesRemoved(InterestedCitiesRemoved event,
      Emitter<InterestedCitiesState> emit) async {
    try {
      final result = await sqLiteDatabase.deleteDataWithParams(
          cityName: event.location.name!,
          latitude: event.location.latitude!,
          longitude: event.location.longitude!);
      List<LocalData>? listLocalData = await sqLiteDatabase.fetchAllData();
      if (listLocalData != null) {
        List<String> listCityInLocal =
            await sqLiteDatabase.getListCityInLocalData(listLocalData);
        List<WeatherInfor>? listWeatherInfor = await weatherRepository
            .getListWeatherInforBasedOnListLocation(listCityInLocal);
        emit(InterestedCitiesFetched(listWeatherInfor!));
      } else {
        emit(InterestedCitiesError());
      }
    } catch (e) {
      emit(InterestedCitiesError());
    }
  }
}
