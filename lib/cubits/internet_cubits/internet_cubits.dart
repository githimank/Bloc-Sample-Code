import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Create enum of state if state is empty
enum InternetCubitState { initial, gained, lost }

class InternetCubit extends Cubit<InternetCubitState> {
  Connectivity connectivity = Connectivity();
  StreamSubscription? _streamSubscription;
  InternetCubit() : super(InternetCubitState.initial) {
    _streamSubscription = connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetCubitState.gained);
      } else {
        emit(InternetCubitState.lost);
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
