part of 'sign_in_email_cubit.dart';

@immutable
sealed class SignInEmailState {}

final class SignInEmailInitial extends SignInEmailState {}
final class SignInEmailLoading extends SignInEmailState {}
final class SignInEmailSuccess extends SignInEmailState {}
final class SignInEmailFailure extends SignInEmailState {
  final String errorMessge;

  SignInEmailFailure({required this.errorMessge});
}
