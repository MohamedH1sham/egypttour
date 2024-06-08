import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_user_info_state.dart';

class EditUserInfoCubit extends Cubit<EditUserInfoState> {
  final dio = Dio();
  File? avatarFile;
  TextEditingController fullNameController = TextEditingController();

  EditUserInfoCubit() : super(EditUserInfoInitial());
  Future<void> pickImage() async {
    emit(EditUserInfoUploadImageLoading());
    final ImagePicker imagePicker = ImagePicker();
    final XFile? imagegallery =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagegallery != null) {
      avatarFile = File(imagegallery.path);
      emit(EditUserInfoUploadImageSuccess(image: avatarFile));
    } else {
      avatarFile = null;
      emit(EditUserInfoUploadImageFailure());
    }
  }

  Future<void> editUserInfo() async {
    try {
      emit(EditUserInfoLoading());
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      final token = prefs.getString('token');
      dio.options.headers['Authorization'] = 'Bearer $token';
      if (id == null || token == null) {
        throw Exception("Missing id or token");
      }
      final url = 'https://finish-api.onrender.com/api/user/$id';
      final response = await dio.patch(url, data: {
        "fullname": fullNameController.text,
        if (avatarFile != null && await avatarFile!.exists())
          "avatar": await MultipartFile.fromFile(avatarFile!.path),
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(EditUserInfoSuccess());
        print(response.data);
      }
    } catch (e) {
      emit(EditUserInfoFailure(errorMessage: e.toString()));
    }
  }
}
