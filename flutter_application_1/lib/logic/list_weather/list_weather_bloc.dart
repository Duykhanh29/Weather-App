import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';
import 'package:meta/meta.dart';

part 'list_weather_event.dart';
part 'list_weather_state.dart';

class ListWeatherBloc extends Bloc<ListWeatherEvent, ListWeatherState> {
  ListWeatherBloc({required this.weatherRepository})
      : super(ListWeatherInitial()) {
    on<ListWeatherStarted>(onStarted);
    on<ListWeatherSearchTextChangedEvent>(onListWeatherSearchTextChangedEvent);
  }
  final WeatherRepository weatherRepository;
  Future onStarted(
      ListWeatherStarted event, Emitter<ListWeatherState> emit) async {
    emit(ListWeatherInitial());
  }

  Future onListWeatherSearchTextChangedEvent(
      ListWeatherSearchTextChangedEvent event,
      Emitter<ListWeatherState> emit) async {
    emit(ListWeatherLoading());
    try {
      if (event.searchKey != '' && event.searchKey.isNotEmpty) {
        List<WeatherInfor>? listWeatherInfor = await weatherRepository
            .getListWeatherInforBasedOnListLocation([event.searchKey]);
        WeatherInfor? weatherInfor =
            await weatherRepository.getWeatherInforForLocation(event.searchKey);
        print(weatherInfor);
        emit(ListWeatherFetched(listWeatherInfor));
      } else {
        emit(ListWeatherInitial());
      }
    } catch (e) {
      emit(ListWeatherError());
    }
  }
}
