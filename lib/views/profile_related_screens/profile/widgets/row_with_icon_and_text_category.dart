import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RowWithIconAndCategoryText extends StatelessWidget {
  final String svg;
  final String categoryName;
  const RowWithIconAndCategoryText({super.key, required this.svg, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SvgPicture.asset(svg,height: 30,),
          widthSpace(20),
          Text(categoryName,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: ColorsManager.primaryColor,
          ),)
        ],
      ),
    );
  }
}