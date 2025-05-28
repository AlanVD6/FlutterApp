import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Popular_screen.dart';
import 'package:flutter_application_1/screens/detail_popular_movie.dart';
import 'package:flutter_application_1/screens/challenge_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/contador_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/utils/global_values.dart';
import 'package:flutter_application_1/utils/theme_settings.dart';
import 'package:flutter_application_1/screens/favorite_movies.dart';


void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: GlobalValues.themeMode,
      builder: (context, value, Widget) {
        return MaterialApp(
          theme: ThemeSettings.setTheme(value),
          home: const LoginScreen(),

            routes: {
            "/dash": (context) => const DashboardScreen(),
            "/reto": (context) => const ChallengeScreen(),
            "/contador": (context) => const ContadorScreen(),
            "/api" : (context) => const PopularScreen(),
            "/detail" : (context) => const DetailPopularMovie(),
            "/favorites": (context) => const FavoriteMovies(),
            }
        );
      }
    );
  }
}