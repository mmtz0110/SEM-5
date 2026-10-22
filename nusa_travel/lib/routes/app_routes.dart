import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../screens/booking_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/splash_screen.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const detail = '/detail';
  static const booking = '/booking';

  static final routes = <String, WidgetBuilder>{
    splash: (_) => const SplashScreen(),
    home: (_) => const HomeScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final package = settings.arguments;
      if (package is TourPackage) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => DetailScreen(package: package),
        );
      }
    }

    if (settings.name == booking) {
      final package = settings.arguments;
      if (package is TourPackage) {
        return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => BookingScreen(package: package),
        );
      }
    }

    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => NotFoundScreen(routeName: settings.name),
    );
  }
}
