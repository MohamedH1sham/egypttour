import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/changers/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:egypttour/routing/app_router.dart';
import 'package:egypttour/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EgyptTour extends StatelessWidget {
  final AppRouter appRouter;

  const EgyptTour({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeChangerCubit, ThemeChangerState>(
      builder: (context, themeState) {
        bool isDarkModeEnabled = themeState is ThemeChangerChanged && themeState.isDarkModee
            ? themeState.isDarkModee
            : MediaQuery.platformBrightnessOf(context) == Brightness.dark;
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
          themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          initialRoute: Routes.loginScreen,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}