import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInSignInUp extends StatelessWidget {
  final String textWelcomeOrGetStarted;
  const TextInSignInUp({super.key, required this.textWelcomeOrGetStarted});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(children: [
        heightSpace(20),
        Text(
          textWelcomeOrGetStarted,
          style: GoogleFonts.sora(
            color: ColorsManager.navyBlue,
            fontSize: 24,
            fontWeight: FontWeight.w600
          ),
        ),
        heightSpace(12),
        Text('Enter your details below'.tr(),
        style: GoogleFonts.sora(
          color: ColorsManager.darkGrey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),),
      ]),
    );
  }
}
