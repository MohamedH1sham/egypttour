import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/routing/routes.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/profile_related_screens/profile/data/cubit/get_user_information_cubit.dart';
import 'package:egypttour/views/profile_related_screens/profile/widgets/row_with_icon_and_text_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<String> svgs = [
    'assets/svgs/personal.svg',
    'assets/svgs/security.svg',
    'assets/svgs/favorites.svg',
    'assets/svgs/help.svg',
    'assets/svgs/about_us.svg',
  ];
  final List<String> categoryName = [
    'General Inforamtion'.tr(),
    'Security'.tr(),
    'Favourites'.tr(),
    'Help'.tr(),
    'About Us'.tr(),
  ];
  final List<String> screensName = [
    Routes.generalInformation,
    Routes.securityScreen,
    Routes.favourties,
    Routes.helpView,
    Routes.aboutView,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => GetUserInformationCubit()..fetchUserInfo(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child:
                BlocBuilder<GetUserInformationCubit, GetUserInformationState>(
              builder: (context, state) {
                if (state is GetUserInformationLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.primaryColor,
                    ),
                  );
                } else if (state is GetUserInformationSuccess) {
                  final userInfo = state.userInfo;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 137,
                        width: 137,
                        // child: CircleAvatar(
                        // backgroundImage: userInfo.avatar != null &&
                        //         userInfo.avatar!.isNotEmpty
                        //     ? NetworkImage(userInfo.avatar![0])
                        //     : const AssetImage('assets/images/person.jpg')
                        //         as ImageProvider,
                        //   radius: 364,
                        // ),
                      ),
                      heightSpace(20),
                      Text(
                        userInfo.fullname,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.brown,
                        ),
                      ),
                      heightSpace(10),
                      Text(
                        userInfo.email,
                        style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: ColorsManager.brown,
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: ColorsManager.offWhite,
                      ),
                      heightSpace(15),
                      Expanded(
                        child: ListView.builder(
                          itemCount: svgs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (index == screensName.length) {
                                } else if (screensName[index].isNotEmpty) {
                                  Navigator.pushNamed(
                                      context, screensName[index]);
                                }
                              },
                              child: RowWithIconAndCategoryText(
                                  svg: svgs[index],
                                  categoryName: categoryName[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
