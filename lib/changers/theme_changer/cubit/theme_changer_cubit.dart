import 'package:bloc/bloc.dart';
part 'theme_changer_state.dart';

class ThemeChangerCubit extends Cubit<ThemeChangerState> {
  ThemeChangerCubit() : super(ThemeChangerInitial());
  bool _isDarkModee = false;

  bool get isDarkModee => _isDarkModee;

  void toggleTheme(bool value) {
    _isDarkModee = value;
    emit(ThemeChangerChanged(_isDarkModee));
  }
}
