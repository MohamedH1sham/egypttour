import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/changers/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:egypttour/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/favourites_screen/favourites_screen.dart';
import 'package:egypttour/views/floating_action/city_text_and_endpoint_model.dart';
import 'package:egypttour/views/home_screen/home_screen.dart';
import 'package:egypttour/views/login_screen/login_screen.dart';
import 'package:egypttour/views/profile_related_screens/profile/data/cubit/get_user_information_cubit.dart';
import 'package:egypttour/views/profile_related_screens/profile/profile_screen.dart';
import 'package:egypttour/views/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingActionButtonScreen extends StatefulWidget {
  const FloatingActionButtonScreen({super.key});

  @override
  State<FloatingActionButtonScreen> createState() =>
      _FloatingActionButtonScreenState();
}

class _FloatingActionButtonScreenState
    extends State<FloatingActionButtonScreen> {
  int _selectedIndex = 0;
  final List<String> imageAssets = [
    'assets/images/portSaid.jpg',
    'assets/images/Cairo.png',
    'assets/images/Fayoum.png',
    'assets/images/Aswan.png',
    'assets/images/Alexandria.png',
    'assets/images/Luxor.png',
  ];
  List<CityModel> cities = [
    CityModel(
      cityText: 'Port Said'.tr(),
      endpointEn: '6633d4c8823b68249b2ac122',
      endpointAr: '664d0e0996363511224c15de',
      weatherEndPoint: 'Port said',
    ),
    CityModel(
      cityText: 'Cairo'.tr(),
      endpointEn: '6633d356823b68249b2abf5e',
      endpointAr: '664d09b496363511224c13e2',
      weatherEndPoint: 'Cairo',
    ),
    CityModel(
      cityText: 'Fayoum'.tr(),
      endpointEn: '6633d648823b68249b2ac1ee',
      endpointAr: '664d0cd496363511224c1504',
      weatherEndPoint: 'Fayoum',
    ),
    CityModel(
      cityText: 'Aswan'.tr(),
      endpointEn: '663d0e2f6c5426b2e2279fba',
      endpointAr: '664a2e45d2481d0c0c8c9d90',
      weatherEndPoint: 'Aswan',
    ),
    CityModel(
      cityText: 'Alexandria'.tr(),
      endpointEn: '6633d2a7823b68249b2abe5c',
      endpointAr: '664c6857191fb4437fad6f53',
      weatherEndPoint: 'Alex',
    ),
    CityModel(
      cityText: 'Luxor'.tr(),
      endpointEn: '6633eb26823b68249b2ac2c8',
      endpointAr: '664c67d9191fb4437fad6e81',
      weatherEndPoint: 'Luxor',
    ),
  ];

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(
        imageAssets: imageAssets,
        cities: cities,
      ),
      const FavouritesScreen(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: BlocProvider(
          create: (context) => GetUserInformationCubit()..fetchUserInfo(),
          child: BlocBuilder<GetUserInformationCubit, GetUserInformationState>(
            builder: (context, state) {
              if (state is GetUserInformationLoading) {
                return const SizedBox(
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                );
              }

              if (state is GetUserInformationSuccess) {
                final userInfo = state.userInfo;
                return Column(
                  children: [
                    // SizedBox(
                    //   height: 180,
                    //   width: 180,
                    // child: CircleAvatar(
                    // ignore: unnecessary_type_check
                    // backgroundImage: state is GetUserInformationSuccess
                    //     ? NetworkImage(userInfo.avatar[0])
                    // : const AssetImage('assets/images/person.png'),
                    // radius: 364,
                    // ),
                    // ),
                    heightSpace(50),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      userInfo.fullname,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.brown,
                      ),
                    ),
                    heightSpace(10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      userInfo.email,
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.brown,
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: ColorsManager.offWhite,
                    ),
                    BlocBuilder<ThemeChangerCubit, ThemeChangerState>(
                      builder: (context, state) {
                        return SwitchListTile(
                          title: const Text('Dark Mode'),
                          value: state is ThemeChangerChanged
                              ? state.isDarkModee ?? false
                              : false,
                          onChanged: (newValue) {
                            context
                                .read<ThemeChangerCubit>()
                                .toggleTheme(newValue);
                          },
                        );
                      },
                    ),
                    ElevatedButtonForSignInUp(
                      signInOrUp: 'Log out'.tr(),
                      onPressed: () {
                        Future.delayed(
                          Duration.zero,
                          () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ThemeChangerCubit, ThemeChangerState>(
          builder: (context, state) {
            return AppBar(
              backgroundColor: state is ThemeChangerChanged && state.isDarkModee
                  ? Colors.black
                  : const Color.fromARGB(255, 255, 249, 235),
              actions: [
                Image.asset('assets/images/tourist.png',height: 45),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchScreen(
                          cities: cities,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BlocBuilder<ThemeChangerCubit, ThemeChangerState>(
        builder: (context, state) {
          return BottomNavigationBar(
            backgroundColor: state is ThemeChangerChanged && state.isDarkModee
                ? Colors.black
                : const Color.fromARGB(255, 255, 249, 235),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: 'Favourites'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: 'Profile'.tr(),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: state is ThemeChangerChanged && state.isDarkModee
                ? Colors.white
                : Colors.brown,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }
}
