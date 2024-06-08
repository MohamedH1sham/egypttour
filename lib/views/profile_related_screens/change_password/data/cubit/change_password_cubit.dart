import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final Dio dio = Dio();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwrodController = TextEditingController();
  TextEditingController passwrodConfirmController = TextEditingController();

  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> changePassword() async {
    try {
      emit(ChangePasswordLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      // Set up the headers
      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
          'User-Agent': 'PostmanRuntime/7.39.0',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
      );

      const url = 'https://finish-api.onrender.com/api/user/resetPassword';

      final response = await dio.patch(
        url,
        data: {
          "email": emailController.text,
          "code": codeController.text,
          "password": passwrodController.text,
          "passwordConfirm": passwrodConfirmController.text
        },
        options: options,
      );

      if (response.statusCode == 201) {
        emit(ChangePasswordSuccess());
        print(response.data);
      } else {
        emit(ChangePasswordFailure(
            errorMessage: 'Error: ${response.data["message"]}'));
      }
    } on DioException catch (e) {
      emit(ChangePasswordFailure(errorMessage: '${e.message}'));
      print(e.response?.data);
    } catch (e) {
      emit(ChangePasswordFailure(errorMessage: e.toString()));
    }
  }
}
