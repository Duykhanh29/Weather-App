part of 'interested_cities_bloc.dart';

@immutable
class InterestedCitiesEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InterestedCitiesStarted extends InterestedCitiesEvent {
  // List<LocalData> listLocalData;
  // InterestedCitiesStarted(this.listLocalData);
  // @override
  // // TODO: implement props
  // List<Object?> get props => [listLocalData];
}

class InterestedCitiesAdded extends InterestedCitiesEvent {
  Location location;
  InterestedCitiesAdded(this.location);
  @override
  // TODO: implement props
  List<Object?> get props => [location];
}

class InterestedCitiesRemoved extends InterestedCitiesEvent {
  Location location;
  InterestedCitiesRemoved(this.location);
  @override
  // TODO: implement props
  List<Object?> get props => [location];
}
