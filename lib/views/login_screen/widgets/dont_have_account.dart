import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DontHaveAccount extends StatelessWidget {
  final void Function()? onPressed;

  const DontHaveAccount({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Don\'t have account?'.tr(),
            style: GoogleFonts.inter(
              
              color: ColorsManager.navyBlue,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
            child: Text(
              'Sign Up here'.tr(),
              style: GoogleFonts.inter(
                color: ColorsManager.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
