import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/weather_infor.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.weatherRepo}) : super(WeatherInitial()) {
    // TODO: implement event handler
    on<WeatherStarted>(onWeatherStarted);
  }
  final WeatherRepository weatherRepo;
  Future<void> onWeatherStarted(
      WeatherStarted event, Emitter<WeatherState> emit) async {
    emit(WeatherFetchLoading());
    try {
      WeatherInfor? weatherInfor = await weatherRepo.getWeatherInforForLongLat(
          event.longitude, event.latitude);
      if (weatherInfor != null) {
        emit(WeatherFetchSuccess(weatherInfor: weatherInfor));
      } else {
        emit(WeatherFetchError());
      }
    } catch (e) {
      emit(WeatherFetchError());
    }
  }
  // Future<void> onWeatherFetched(WeatherFetched event,Emitter<WeatherState> emit)async{
  //   emit()
  // }
}
