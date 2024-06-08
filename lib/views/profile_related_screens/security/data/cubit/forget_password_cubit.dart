import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  TextEditingController emailController = TextEditingController();
  final Dio dio = Dio();
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  Future<void> forgetPassword() async {
    try {
      emit(ForgetPasswordLoading());
      const url = 'https://finish-api.onrender.com/api/user/forgetPassword/';
      final response = await dio.post(url, data: {
        "email": emailController.text,
      });
      if (response.statusCode == 200) {
        emit(ForgetPasswordSuccess());
        print(response.data);
      }
      if (response.data['status'] == 'success') {
      } else {
        print("${response.statusCode} =============== ${response.data}");
      }
    } catch (e) {
      emit(ForgetPasswordFailure(errorMessage: e.toString()));
    }
  }
}
