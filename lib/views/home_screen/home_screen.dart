import 'package:egypttour/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/views/floating_action/city_text_and_endpoint_model.dart';
import 'package:egypttour/views/home_screen/widgets/city_container.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {
  final List<String> imageAssets;
  final List<CityModel> cities;

  const HomeScreen({
    super.key,
    required this.imageAssets,
    required this.cities,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Explore Egypt'.tr(),
                  style: TextStyle(
                      color: ColorsManager.primaryColor,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 16.w, bottom: 15.h),
                  child: Text(
                    "what's new".tr(),
                    style: TextStyle(
                        fontSize: 24.sp, color: ColorsManager.primaryColor),
                  ),
                ),
                SlideShow(imageAssets: imageAssets),
                heightSpace(30),
                Text(
                  'newss'.tr(),
                  style: TextStyle(
                      fontSize: 19.sp, color: ColorsManager.primaryColor),
                ),
                Divider(
                  color: ColorsManager.primaryColor,
                  endIndent: 50.w,
                  thickness: 1.w,
                  indent: 50.w,
                ),
                Text(
                  "Browse your journey".tr(),
                  style: TextStyle(
                      color: Color(0xffc39126),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 1000.h,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.6),
                    itemCount: imageAssets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CityContainer(
                        imageAsset: imageAssets[index],
                        cityText: cities[index].cityText,
                        endpointAr: cities[index].endpointAr,
                        endpointEn: cities[index].endpointEn,
                        weatherEndPoint: cities[index].weatherEndPoint,
                      );
                    },
                  ),
                ),
                heightSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SlideShow extends StatefulWidget {
  final List<String> imageAssets;

  const SlideShow({
    super.key,
    required this.imageAssets,
  });

  @override
  _SlideShowState createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.imageAssets.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: PageView(
        controller: _controller,
        children: widget.imageAssets.map((imageAsset) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
      ),
    );
  }
}
