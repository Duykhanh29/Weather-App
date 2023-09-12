part of 'list_weather_bloc.dart';

@immutable
class ListWeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListWeatherInitial extends ListWeatherState {}

class ListWeatherFetched extends ListWeatherState {
  final List<WeatherInfor>? listWeatherInfor;
  ListWeatherFetched(this.listWeatherInfor);
  @override
  List<Object> get props => [listWeatherInfor!];
}

class ListWeatherLoading extends ListWeatherState {}

class ListWeatherError extends ListWeatherState {}
