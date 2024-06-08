part of 'get_user_information_cubit.dart';

sealed class GetUserInformationState {}

final class GetUserInformationInitial extends GetUserInformationState {}
final class GetUserInformationLoading extends GetUserInformationState {}
final class GetUserInformationSuccess extends GetUserInformationState {
  final UserInfo userInfo;

  GetUserInformationSuccess({required this.userInfo});
}
final class GetUserInformationFailure extends GetUserInformationState {
  final String errorMessage;

  GetUserInformationFailure({required this.errorMessage});
}
