import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ButtonUploadIamge extends StatelessWidget {
  final void Function()? onTap;
  const ButtonUploadIamge({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 60.w,
      decoration:
          const BoxDecoration(color: ColorsManager.primaryColor, shape: BoxShape.circle),
      child: InkWell(
        onTap: onTap,
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
