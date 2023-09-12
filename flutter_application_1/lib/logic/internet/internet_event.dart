part of 'internet_bloc.dart';

@immutable
class InternetEvent {}

class InternetConnectedSuccessfully extends InternetEvent {}

class InternetConnectedFaily extends InternetEvent {}

class DisconnetInternet extends InternetEvent {}
