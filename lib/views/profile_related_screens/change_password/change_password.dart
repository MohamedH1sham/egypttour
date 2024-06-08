import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/mutual_widgets/custom_snack_bar.dart';
import 'package:egypttour/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:egypttour/mutual_widgets/repeated_text_field.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/login_screen/login_screen.dart';
import 'package:egypttour/views/profile_related_screens/change_password/data/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            showCustomSnackbar(context, "Success".tr(), ColorsManager.brown);
            Future.delayed(
              Duration.zero,
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            );
          } else if (state is ChangePasswordFailure) {
            showCustomSnackbar(context, state.errorMessage, ColorsManager.red);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                heightSpace(50),
                RepeatedTextFormField(
                  hintText: "Enter email".tr(),
                  controller:
                      context.read<ChangePasswordCubit>().emailController,
                  hide: false,
                ),
                heightSpace(30),
                RepeatedTextFormField(
                  hintText: "enter code".tr(),
                  controller:
                      context.read<ChangePasswordCubit>().codeController,
                  hide: false,
                ),
                heightSpace(30),
                RepeatedTextFormField(
                  hintText: "Enter password".tr(),
                  controller:
                      context.read<ChangePasswordCubit>().passwrodController,
                  hide: false,
                ),
                heightSpace(30),
                RepeatedTextFormField(
                  hintText: "Confirm password".tr(),
                  controller: context
                      .read<ChangePasswordCubit>()
                      .passwrodConfirmController,
                  hide: false,
                ),
                heightSpace(250),
                ElevatedButtonForSignInUp(
                  signInOrUp: "Reset password".tr(),
                  onPressed: () {
                    context.read<ChangePasswordCubit>().changePassword();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
