part of 'weather_bloc.dart';

class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherStarted extends WeatherEvent {
  final double latitude;
  final double longitude;
  WeatherStarted({required this.latitude, required this.longitude});
  @override
  List<Object> get props => [longitude, latitude];
}

class WeatherFetched extends WeatherEvent {
  final WeatherInfor weatherInfor;
  WeatherFetched(this.weatherInfor);

  @override
  List<Object> get props => [weatherInfor];
}

class WeatherFailed extends WeatherEvent {}
// class WeatherLocationAdded extends WeatherEvent {
//   final WeatherInfor weatherInfor;
//   WeatherLocationAdded({required this.weatherInfor});
//   @override
//   List<Object> get props => [weatherInfor];
// }

// class WeatherLocationremoved extends WeatherEvent {
//   final WeatherInfor weatherInfor;
//   WeatherLocationremoved({required this.weatherInfor});
//   @override
//   List<Object> get props => [weatherInfor];
// }

// class WeatherLocationSearched extends WeatherEvent {
//   final String searchKey;
//   WeatherLocationSearched({required this.searchKey});
//   @override
//   List<Object> get props => [searchKey];
// }
