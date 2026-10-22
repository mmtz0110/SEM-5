import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(const NusaTravelApp());
}

class NusaTravelApp extends StatelessWidget {
  const NusaTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    const deepGreen = Color(0xFF173B35);
    const terracotta = Color(0xFFC76645);
    const sand = Color(0xFFF5EFE6);

    return MaterialApp(
      title: 'NusaTravel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: sand,
        colorScheme: ColorScheme.fromSeed(
          seedColor: terracotta,
          primary: deepGreen,
          secondary: terracotta,
          surface: sand,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: sand,
          foregroundColor: deepGreen,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE3D8CB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: deepGreen, width: 2),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
