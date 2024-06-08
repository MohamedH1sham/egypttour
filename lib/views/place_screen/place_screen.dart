import 'package:flutter/material.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/home_screen/data/place_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceScreen extends StatelessWidget {
  final String placeNameText;
  final String placeDescription;
  final String img;
  final String rating;
  final List<TimeSlot>? time;
  final String placeLocation;

  const PlaceScreen({
    super.key,
    required this.placeNameText,
    required this.placeDescription,
    required this.img,
    required this.rating,
    required this.time,
    required this.placeLocation,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //delete image
              SizedBox(
                height: 380.h,
                child: PanoramaViewer(
                  // تلغي الويديجت دي هتشتغل معاك
                  child: Image.network(
                    'https://docs.google.com/uc?id=${extractDriveId(img)}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // comment to it.
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          placeNameText.length > 15
                              ? '${placeNameText.substring(0, 15)}...'
                              : placeNameText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorsManager.brown,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Rating: $rating',
                          style: TextStyle(
                            color: ColorsManager.brown,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      placeDescription,
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 25.sp,
                        color: ColorsManager.brown,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Image.asset('assets/images/Days to visit.png'),
                    SizedBox(height: 20.h),
                    if (time != null) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buildTimes(),
                      ),
                      SizedBox(height: 20.h),
                    ],
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.location_pin,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                      onPressed: () {
                        launchMaps(placeLocation);
                      },
                      label: Text(
                        'Location.',
                        style: TextStyle(
                          color: ColorsManager.brown,
                          fontSize: 20.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 246, 214, 144),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String extractDriveId(String url) {
    try {
      Uri uri = Uri.parse(url);

      String? id = uri.queryParameters['id'];
      if (id != null && id.isNotEmpty) {
        return id;
      }

      RegExp regExp =
          RegExp(r'^https:\/\/drive\.google\.com\/file\/d\/([^\/]+)\/?.*$');
      Match? match = regExp.firstMatch(url);
      if (match != null && match.groupCount > 0) {
        return match.group(1) ?? '';
      }

      return '';
    } catch (e) {
      return '';
    }
  }

  List<Widget> buildTimes() {
    return time!.map((timeSlot) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${timeSlot.day}:',
              style: TextStyle(
                color: ColorsManager.brown,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              timeSlot.timeSlot,
              style: TextStyle(
                color: ColorsManager.brown,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Future<void> launchMaps(String location) async {
    String googleMapsUrl = Uri.encodeFull(location);

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
