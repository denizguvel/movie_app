import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class BottomNavbarState extends Equatable {
  final int selectedIndex;
  const BottomNavbarState({this.selectedIndex = 0});

  @override
  List<Object?> get props => [selectedIndex];
}

abstract class BottomNavbarEvent extends Equatable {
  const BottomNavbarEvent();
}

class NavbarItemSelected extends BottomNavbarEvent {
  final int index;
  const NavbarItemSelected(this.index);

  @override
  List<Object?> get props => [index];
}

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc() : super(const BottomNavbarState()) {
    on<NavbarItemSelected>((event, emit) {
      emit(BottomNavbarState(selectedIndex: event.index));
    });
  }
} 