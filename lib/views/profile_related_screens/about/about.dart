import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  final List<String> images = [
    'assets/images/Rectangle173.png',
    'assets/images/Rectangle174.png',
    'assets/images/Rectangle175.png',
    'assets/images/Rectangle176.png',
    'assets/images/Rectangle177.png',
    'assets/images/Rectangle178.png',
  ];

  AboutScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "about_title".tr(),
                        style: GoogleFonts.cairo(
                          color: ColorsManager.primaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      heightSpace(10),
                      Text(
                        'egyptour_description'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                heightSpace(20),
                Text(
                  'offers_title'.tr(),
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                ),
                heightSpace(7),
                Text(
                  'experience_title'.tr(),
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                heightSpace(5),
                Text(
                  'incredible_experience_description'.tr(),
                  style: GoogleFonts.cairo(
                    height: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  'no_fees_title'.tr(),
                  style: GoogleFonts.cairo(
                    height: 2,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'no_fees_description'.tr(),
                  style: GoogleFonts.cairo(
                    height: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'support_title'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'support_description'.tr(),
                  style: GoogleFonts.cairo(
                    height: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'evolution_title'.tr(),
                  style: GoogleFonts.cairo(
                    height: 2,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'evolution_description'.tr(),
                  style: GoogleFonts.cairo(
                    height: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightSpace(5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
