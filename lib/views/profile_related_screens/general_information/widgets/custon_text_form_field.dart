import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  const CustomTextFormField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 200.w,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.changa(
                  color: ColorsManager.navyBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              SvgPicture.asset('assets/svgs/write.svg'),
            ],
          ),
          heightSpace(5),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
            )),
          ),
          heightSpace(15),
        ],
      ),
    );
  }
}
