import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/changers/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:egypttour/changers/language_changer/cubit/language_changer_cubit.dart';
import 'package:egypttour/egypt_tour.dart';
import 'package:egypttour/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//git done changed test
void main() {
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      saveLocale: true,
      useOnlyLangCode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeChangerCubit()),
          BlocProvider(create: (context) => LanguageChangerCubit(context)),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      minTextAdapt: true,
      child: BlocBuilder<ThemeChangerCubit, ThemeChangerState>(
        builder: (context, themeState) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  brightness: Brightness.light,
                  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 249, 235),
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: Colors.black,
                ),
                themeMode: themeState is ThemeChangerChanged && themeState.isDarkModee
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: EgyptTour(
                  appRouter: appRouter,
                ),
              );
            },
          ),
    );
      }
  }
