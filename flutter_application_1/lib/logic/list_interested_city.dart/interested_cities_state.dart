part of 'interested_cities_bloc.dart';

@immutable
class InterestedCitiesState {}

class InterestedCitiesInitial extends InterestedCitiesState {}

class InterestedCitiesFetched extends InterestedCitiesState {
  final List<WeatherInfor>? listWeatherInfor;
  InterestedCitiesFetched(this.listWeatherInfor);
  @override
  List<Object> get props => [listWeatherInfor!];
}

class InterestedCitiesError extends InterestedCitiesState {}

class InterestedEmptyCities extends InterestedCitiesState {}
