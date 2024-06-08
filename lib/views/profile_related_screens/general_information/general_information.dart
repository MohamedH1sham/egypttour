import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:egypttour/mutual_widgets/repeated_text_field.dart';
import 'package:egypttour/mutual_widgets/two_buttons_in_two_screens.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/profile_related_screens/general_information/data/cubit/edit_user_info_cubit.dart';
import 'package:egypttour/views/profile_related_screens/profile/data/cubit/get_user_information_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralInFormation extends StatelessWidget {
  const GeneralInFormation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => GetUserInformationCubit()..fetchUserInfo(),
        child: BlocBuilder<GetUserInformationCubit, GetUserInformationState>(
          builder: (context, state) {
            if (state is GetUserInformationLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.primaryColor,
                  ),
                ),
              );
            }
            if (state is GetUserInformationSuccess) {
              final userInfo = state.userInfo;
              return BlocProvider(
                create: (context) => EditUserInfoCubit(),
                child: Scaffold(
                  body: BlocBuilder<EditUserInfoCubit, EditUserInfoState>(
                    builder: (context, editState) {
                      if (editState is EditUserInfoSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                        });
                      } else if (editState is EditUserInfoLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorsManager.primaryColor,
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightSpace(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Personal details and Adresses".tr(),
                              style: GoogleFonts.montserrat(
                                color: ColorsManager.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          heightSpace(30),
                          const Divider(
                            color: ColorsManager.primaryColor,
                            height: 1,
                          ),
                          heightSpace(30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RepeatedTextFormField(
                                  controller: context
                                      .read<EditUserInfoCubit>()
                                      .fullNameController,
                                  hintText: "Full name".tr(),
                                  keyboardType: TextInputType.name,
                                  hide: false,
                                ),
                                heightSpace(20),
                                RepeatedTextFormField(
                                  controller: TextEditingController(),
                                  hintText: "Change E-mail address".tr(),
                                  hide: false,
                                ),
                                heightSpace(20),
                                DropdownButtonFormField<String>(
                                  borderRadius: BorderRadius.circular(20),
                                  focusColor: ColorsManager.primaryColor,
                                  value: null,
                                  onChanged: (value) {},
                                  items: <String>['Male'.tr(), 'Female'.tr()]
                                      .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.sora(
                                              color: ColorsManager.primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  decoration: InputDecoration(
                                    labelText: 'Gender'.tr(),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                heightSpace(20),
                                DateSelectionWidget(),
                                heightSpace(20),
                              ],
                            ),
                          ),
                          heightSpace(30),
                          Center(
                            child: TwoButtonsInTwoScreens(
                              onPressedSaved: context
                                  .read<EditUserInfoCubit>()
                                  .editUserInfo,
                              onPressedDiscared: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            } else if (state is GetUserInformationFailure) {
              return Text(state.errorMessage);
            } else {
              return Scaffold(body: Container());
            }
          },
        ),
      ),
    );
  }
}

class DateSelectionWidget extends StatefulWidget {
  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButtonForSignInUp(
          signInOrUp: 'Select Date'.tr(),
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
        ),
        heightSpace(10),
        if (selectedDate != null)
          Text(
            'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
            style: GoogleFonts.sora(
              color: ColorsManager.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
      ],
    );
  }
}
