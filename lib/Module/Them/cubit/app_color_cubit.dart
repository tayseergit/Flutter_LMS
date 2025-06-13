import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light());

  void toggleTheme() {
    if (state.isDarkMode) {
      emit(ThemeState.light());
    } else {
      emit(ThemeState.dark());
    }
  }
}
