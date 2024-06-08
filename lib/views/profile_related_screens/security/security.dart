import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/mutual_widgets/repeated_text_field.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/login_screen/login_screen.dart';
import 'package:egypttour/views/profile_related_screens/change_password/change_password.dart';
import 'package:egypttour/views/profile_related_screens/change_password/data/cubit/change_password_cubit.dart';
import 'package:egypttour/views/profile_related_screens/profile/data/cubit/get_user_information_cubit.dart';
import 'package:egypttour/views/profile_related_screens/security/data/cubit/delete_user_cubit.dart';
import 'package:egypttour/views/profile_related_screens/security/data/cubit/forget_password_cubit.dart';
import 'package:egypttour/views/profile_related_screens/security/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetUserInformationCubit()..fetchUserInfo(),
          ),
          BlocProvider(
            create: (context) => DeleteUserCubit(),
          ),
        ],
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      // SizedBox(
                      // height: 120,
                      // width: 120,
                      // child: BlocBuilder<GetUserInformationCubit,
                      //     GetUserInformationState>(builder: (context, state) {
                      //   if (state is GetUserInformationFailure) {
                      //     print('Failed'.tr());
                      //   }
                      // return CircleAvatar(
                      // backgroundImage: state is GetUserInformationSuccess
                      //     ? NetworkImage(state.userInfo.avatar[0])
                      //     : const AssetImage('assets/images/person.jpg'),
                      // radius: 200,
                      // );
                      // }),
                      // ),
                      SizedBox(
                        width: 220,
                        child: Column(
                          children: [
                            Text(
                              'Security'.tr(),
                              style: GoogleFonts.changa(
                                fontSize: 40,
                                color: ColorsManager.primaryColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            heightSpace(10),
                            Text(
                              "change security".tr(),
                              style: GoogleFonts.changa(
                                height: 2,
                                color: ColorsManager.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  heightSpace(20),
                  CardContainer(
                    maintext: 'Password'.tr(),
                    desc: 'change your password'.tr(),
                    textButton: 'Change Password'.tr(),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => ForgetPasswordCubit(),
                            child: BlocBuilder<ForgetPasswordCubit,
                                ForgetPasswordState>(
                              builder: (context, state) {
                                if (state is ForgetPasswordSuccess) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider(
                                        create: (context) =>
                                            ChangePasswordCubit(),
                                        child: const ChangePassword(),
                                      ),
                                    ),
                                  );
                                }
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Change Password'.tr(),
                                          style: GoogleFonts.cairo(
                                            color: ColorsManager.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      heightSpace(
                                          20), // Replace heightSpace(20)
                                      RepeatedTextFormField(
                                        hintText: 'Enter email'.tr(),
                                        controller: context
                                            .read<ForgetPasswordCubit>()
                                            .emailController,
                                        hide: false,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<ForgetPasswordCubit>()
                                              .forgetPassword();
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (_) => BlocProvider(
                                          //       create: (context) =>
                                          //           ChangePasswordCubit(),
                                          //       child: const ChangePassword(),
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: state is ForgetPasswordLoading
                                            ? const CircularProgressIndicator()
                                            : Text('Click here'.tr()),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  heightSpace(8),
                  CardContainer(
                    maintext: 'Active Sessions'.tr(),
                    desc: 'Selecting sign out'.tr(),
                    textButton: 'Sign out'.tr(),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  heightSpace(8),
                  BlocBuilder<DeleteUserCubit, DeleteUserState>(
                    builder: (context, state) {
                      if (state is DeleteUserLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DeleteUserSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (Route<dynamic> route) => false,
                          );
                        });
                      }

                      return CardContainer(
                        maintext: 'Delete Account'.tr(),
                        desc: 'Permanently delete your Egyptour.com'.tr(),
                        textButton: 'Delete Account'.tr(),
                        onPressed: () {
                          context.read<DeleteUserCubit>().deleteUser();
                        },
                      );
                    },
                  ),
                  heightSpace(15),
                  // TwoButtonsInTwoScreens(
                  //   onPressedSaved: () {},
                  //   onPressedDiscared: () {},
                  // ),
                  heightSpace(10),
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: Image.asset(
                      'assets/images/tour.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchGmail() async {
    const url = 'googlegmail://';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch Gmail');
    }
  }
}
