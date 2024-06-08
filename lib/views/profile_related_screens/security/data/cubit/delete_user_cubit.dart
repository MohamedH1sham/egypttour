import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit() : super(DeleteUserInitial());
  final Dio dio = Dio();

  Future<void> deleteUser() async {
    try {
      emit(DeleteUserLoading());
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');
      final token =
          prefs.getString('token'); 
      final url = 'https://finish-api.onrender.com/api/user/$userId';

      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteUserSuccess());
        print(response.data);
      } else {
        emit(DeleteUserFailure(
            errorMessage: 'Failed with status code: ${response.statusCode}'));
        print('Failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        emit(DeleteUserFailure(
            errorMessage: 'Unauthorized: ${e.response?.statusCode}'));
        print('Unauthorized: ${e.response?.statusCode}');
      } else {
        emit(DeleteUserFailure(errorMessage: 'DioError: ${e.message}'));
        print('DioError: ${e.message}');
      }
    } catch (e) {
      emit(DeleteUserFailure(errorMessage: 'An unexpected error occurred: $e'));
      print('An unexpected error occurred: $e');
    }
  }
}
