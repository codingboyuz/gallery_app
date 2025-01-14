
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/features/main/bloc/main_state.dart';

class MainBloc extends Cubit<NavigationState> {
  MainBloc() : super(const NavigationInitial());

  void changeTab(int index) {
    emit(NavigationChanged(index));
  }

}