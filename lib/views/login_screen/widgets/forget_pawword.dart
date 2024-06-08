import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordOrChangePassword extends StatelessWidget {
  final String forgetOrChange;
  final void Function()? onPressed;

  const ForgetPasswordOrChangePassword({super.key, required this.forgetOrChange, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            forgetOrChange,
            style: GoogleFonts.sora(
              color: ColorsManager.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}