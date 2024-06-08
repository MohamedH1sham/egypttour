part of 'edit_user_info_cubit.dart';

sealed class EditUserInfoState extends Equatable {
  const EditUserInfoState();

  @override
  List<Object> get props => [];
}

final class EditUserInfoInitial extends EditUserInfoState {}

final class EditUserInfoUploadImageSuccess extends EditUserInfoState {
  final String imageSuccess = 'Success'.tr();
    final File? image;

  EditUserInfoUploadImageSuccess({required this.image});

}

final class EditUserInfoUploadImageLoading extends EditUserInfoState {}

final class EditUserInfoUploadImageFailure extends EditUserInfoState {
  final String errorMessage = 'Failed'.tr();
}

final class EditUserInfoLoading extends EditUserInfoState {}

final class EditUserInfoSuccess extends EditUserInfoState {}

final class EditUserInfoFailure extends EditUserInfoState {
  final String errorMessage;

  const EditUserInfoFailure({required this.errorMessage});
}
