import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreButton extends StatelessWidget {
  const ExploreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45.h,
        width: 130.w,
        decoration: const BoxDecoration(
            color: ColorsManager.darkerWhite,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                size: 33.h,
                Icons.search,
                color: ColorsManager.primaryColor,
              ),
              Text(
                'Explore'.tr(),
                style: GoogleFonts.sora(
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ));
  }
}
