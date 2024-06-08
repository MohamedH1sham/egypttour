import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_in_email_state.dart';

class SignInEmailCubit extends Cubit<SignInEmailState> {
  SignInEmailCubit() : super(SignInEmailInitial());
  final Dio dio = Dio();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      emit(SignInEmailLoading());
      const url = 'https://finish-api.onrender.com/api/user/login/';
      final response = await dio.post(url, data: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      if (response.statusCode == 200) {
        final token = response.data['data']['token'];
        final id = response.data['data']['id'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('id', id);
        print(token);
        print(id);

        emit(SignInEmailSuccess());
        print("Token stored successfully: $token");
        print(response.data);
      } else {
        final errorMessage =
            response.data['message'] ?? 'Unknown error occurred';
        emit(SignInEmailFailure(errorMessge: errorMessage));
        print(errorMessage);
      }
    } on DioException catch (dioError) {
      if (dioError.response != null && dioError.response!.statusCode == 500) {
        final errorMessage = dioError.response!.data['message'] ??
            'Cannot read properties of null (reading \'email\')';
        emit(SignInEmailFailure(errorMessge: errorMessage));
        print(errorMessage);
      }
    } catch (e) {
      emit(SignInEmailFailure(errorMessge: e.toString()));
      print(e.toString());
    }
  }
}
