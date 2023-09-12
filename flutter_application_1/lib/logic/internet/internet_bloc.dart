import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc({required this.connectivity}) : super(InternetInitial()) {
    on((InternetConnectedSuccessfully event, emit) {
      emit(InternetConnected());
    });
    on((InternetConnectedFaily event, emit) => emit(InternetDisconnected()));
    monitorInternetState();
  }
  StreamSubscription? streamSubscription;
  Connectivity connectivity;
  StreamSubscription monitorInternetState() {
    return streamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResults) {
      if (connectivityResults == ConnectivityResult.wifi ||
          connectivityResults == ConnectivityResult.mobile) {
        add(InternetConnectedSuccessfully());
      } else {
        add(InternetConnectedFaily());
      }
    });
  }

  @override
  void dispose() {
    streamSubscription!.cancel();
  }
}
