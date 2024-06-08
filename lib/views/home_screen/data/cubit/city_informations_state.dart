part of 'city_informations_cubit.dart';

sealed class CityInformationsState {}

@immutable
final class CityInformationsInitial extends CityInformationsState {}

final class CityInformationsLoading extends CityInformationsState {}
final class CityWeatherLoading extends CityInformationsState {}
final class CityWeatherSuccess extends CityInformationsState {
  final CityWeather cityWeather;

  CityWeatherSuccess({required this.cityWeather});
}
final class CityWeatherFailure extends CityInformationsState {
  final String errorMessge;

  CityWeatherFailure({required this.errorMessge});
}

final class CityInformationsSuccess extends CityInformationsState {
  final Governorate governorate;

  CityInformationsSuccess({required this.governorate});
}
final class CityInformationsFailure extends CityInformationsState {
  final String errorMessge;
  CityInformationsFailure({required this.errorMessge});
}
