
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardContainer extends StatelessWidget {
  final String maintext;
  final String desc;
  final String textButton;
  final void Function() onPressed;
  const CardContainer(
      {super.key,
      required this.maintext,
      required this.desc,
      required this.textButton,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.brown,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  maintext,
                  style: GoogleFonts.changa(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: ColorsManager.brown,
                  ),
                ),
              ],
            ),
            heightSpace(13),
            Text(
              textAlign: TextAlign.center,
              desc,
              style: GoogleFonts.changa(
                fontSize: 19,
                fontWeight: FontWeight.w200,
                color: ColorsManager.white,
              ),
            ),
            heightSpace(13),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primaryKey2,
                    shape: RoundedRectangleBorder(
                      
                      side: const BorderSide(width: 1, color: ColorsManager.primaryKey2),
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    textButton,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
