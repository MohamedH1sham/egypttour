import 'package:egypttour/routing/routes.dart';
import 'package:egypttour/views/favourites_screen/favourites_screen.dart';
import 'package:egypttour/views/floating_action/floating_action_button.dart';
import 'package:egypttour/views/login_screen/login_screen.dart';
import 'package:egypttour/views/profile_related_screens/about/about.dart';
import 'package:egypttour/views/profile_related_screens/general_information/general_information.dart';
import 'package:egypttour/views/profile_related_screens/help/help_view.dart';
import 'package:egypttour/views/profile_related_screens/security/security.dart';
import 'package:egypttour/views/register_screen/data/cubit/sign_up_email_cubit.dart';
import 'package:egypttour/views/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'; // Import for SystemNavigator

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpEmailCubit(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.floatingActionButton:
        return MaterialPageRoute(
          builder: (_) => const FloatingActionButtonScreen(),
        );
      case Routes.helpView:
        return MaterialPageRoute(
          builder: (_) => const HelpView(),
        );
      case Routes.aboutView:
        return MaterialPageRoute(
          builder: (_) => AboutScreen(),
        );
      case Routes.securityScreen:
        return MaterialPageRoute(
          builder: (_) => const SecurityScreen(),
        );
      case Routes.favourties:
        return MaterialPageRoute(
          builder: (_) => const FavouritesScreen(),
        );
      case Routes.generalInformation:
        return MaterialPageRoute(
          builder: (_) => const GeneralInFormation(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => _buildExitDialog(),
        );
    }
  }

  Widget _buildExitDialog() {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
