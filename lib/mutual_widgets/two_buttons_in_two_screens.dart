import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoButtonsInTwoScreens extends StatelessWidget {
  final void Function()? onPressedDiscared;
  final void Function()? onPressedSaved;
  const TwoButtonsInTwoScreens({
    super.key, this.onPressedDiscared, this.onPressedSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.brown,
          ),
          onPressed: onPressedDiscared,
          child: Text(
            "Discard".tr(),
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: ColorsManager.white,
            ),
          ),
        ),
        widthSpace(30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 2,
                color: ColorsManager.brown
              ),
              borderRadius: BorderRadius.circular(60)
            ),
          ),
          onPressed: onPressedSaved,
          child: Text(
            "Save change".tr(),
            style: GoogleFonts.montserrat(
              color: ColorsManager.brown,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
