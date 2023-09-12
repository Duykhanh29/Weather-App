part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherFetchLoading extends WeatherState {}

class WeatherFetchSuccess extends WeatherState {
  final WeatherInfor weatherInfor;
  WeatherFetchSuccess({required this.weatherInfor});
  @override
  List<Object> get props => [weatherInfor];
}

class WeatherFetchError extends WeatherState {}
