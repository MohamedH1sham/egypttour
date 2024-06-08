import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightSpace(10),
                Text(
                  'welcome_help_center'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 25,
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightSpace(5),
                Text(
                  'available_24_hours'.tr(),
                  style: GoogleFonts.cairo(
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'faq'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.primaryColor,
                  ),
                ),
                ExpansionTileCard(
                  title: Text(
                    'safety_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'safety_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'visa_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'visa_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'cost_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'cost_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'cultural_tours_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'cultural_tours_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'food_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'food_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'budget_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'budget_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'travel_tips_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'travel_tips_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'who_we_are_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'who_we_are_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'what_we_do_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'what_we_do_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'fees_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'fees_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                ExpansionTileCard(
                  title: Text(
                    'app_question'.tr(),
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'app_answer'.tr(),
                        style: GoogleFonts.cairo(
                          height: 1.5,
                          color: ColorsManager.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(30),
                // Text(
                //   'become_vip'.tr(),
                //   style: GoogleFonts.cairo(
                //     fontSize: 30,
                //     fontWeight: FontWeight.w600,
                //     color: ColorsManager.primaryColor,
                //   ),
                // ),
                // heightSpace(5),
                // Text(
                //   'vip_description'.tr(),
                //   style: GoogleFonts.cairo(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w400,
                //     color: ColorsManager.primaryColor,
                //   ),
                // ),
                // heightSpace(10),
                // ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: ColorsManager.primaryColor,
                //     ),
                //     child: Text(
                //       'upgrade_now'.tr(),
                //       style: GoogleFonts.cairo(
                //         color: ColorsManager.white,
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
