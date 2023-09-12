part of 'list_weather_bloc.dart';

@immutable
class ListWeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListWeatherStarted extends ListWeatherEvent {}

class ListWeatherSearchTextChangedEvent extends ListWeatherEvent {
  final String searchKey;
  ListWeatherSearchTextChangedEvent(this.searchKey);
  @override
  List<Object> get props => [searchKey];
}
