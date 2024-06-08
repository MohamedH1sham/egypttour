import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:egypttour/views/home_screen/data/city_weather.dart';
import 'package:egypttour/views/home_screen/data/place_model.dart'; // Ensure your model file path is correct
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'city_informations_state.dart';

class CityInformationsCubit extends Cubit<CityInformationsState> {
  final String endPoint;
  final String weatherEndPoint;
  CityInformationsCubit(this.endPoint, this.weatherEndPoint)
      : super(CityInformationsInitial());
  final Dio dio = Dio();

  Future<void> fetchPlaces() async {
    final apiUrl = 'https://finish-api.onrender.com/api/gove/$endPoint';
    try {
      emit(CityInformationsLoading());
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        if (jsonResponse['status'] == 'success') {
          final governorate =
              Governorate.fromJson(jsonResponse['data']['gove']);

          emit(CityInformationsSuccess(governorate: governorate));
        } else {
          emit(CityInformationsFailure(
              errorMessge: jsonResponse['error'] ?? 'Unknown API error'));
        }
      } else {
        emit(CityInformationsFailure(
            errorMessge:
                'Request failed with status code ${response.statusCode}'));
      }
    } catch (e) {
      emit(CityInformationsFailure(
          errorMessge: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> getWeather() async {
    final apiWeather =
        'http://api.weatherapi.com/v1/current.json?key=e21eee9a85994dd5bec184609242205&q=$weatherEndPoint&aqi=no';
    try {
      emit(CityWeatherLoading());
      final response = await dio.get(apiWeather);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        final cityWeather = CityWeather.fromJson(jsonResponse);
        emit(CityWeatherSuccess(cityWeather: cityWeather));
        print(response.data);
      } else {
        emit(CityWeatherFailure(errorMessge: '${response.statusCode}'));
      }
    } catch (e) {
      emit(CityWeatherFailure(errorMessge: e.toString()));
    }
  }
}
