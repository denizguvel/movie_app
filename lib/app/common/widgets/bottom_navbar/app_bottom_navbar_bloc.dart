import 'package:flutter_bloc/flutter_bloc.dart';

enum AppBottomNavbarEvent { Home, Profile }

class AppBottomNavbarBloc extends Bloc<AppBottomNavbarEvent, int> {
  AppBottomNavbarBloc() : super(0) {
    on<AppBottomNavbarEvent>((event, emit) {
      emit(event.index);
    });
  }
}
