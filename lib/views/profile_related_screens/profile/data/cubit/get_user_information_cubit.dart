import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:egypttour/views/profile_related_screens/profile/model/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_user_information_state.dart';

class GetUserInformationCubit extends Cubit<GetUserInformationState> {
  final Dio dio = Dio();

  GetUserInformationCubit() : super(GetUserInformationInitial());
  Future<void> fetchUserInfo() async {
    try {
      emit(GetUserInformationLoading());
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');
      print(userId);

      if (userId == null) {
        emit(GetUserInformationFailure(
            errorMessage: 'User ID not found in SharedPreferences'));
        return;
      }

      final url = 'https://finish-api.onrender.com/api/user/$userId';
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final userInfo = UserInfo.fromJson(response.data);
        emit(GetUserInformationSuccess(userInfo: userInfo));
      } else {
        emit(GetUserInformationFailure(
            errorMessage: 'Failed to fetch user information'));
      }
    } catch (e) {
      emit(GetUserInformationFailure(
          errorMessage: 'Failed to fetch user information: $e'));
    }
  }
}
