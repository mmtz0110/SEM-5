import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/dependencies.dart';
import 'data/cafmate_store.dart';
import 'ui/shell/app_shell.dart';

class CafeMateApp extends StatelessWidget {
  const CafeMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: buildDependencies(),
      child: ChangeNotifierProvider(
        create: (_) => CafmateStore(),
        child: const _CafeMateMaterialApp(),
      ),
    );
  }
}

class _CafeMateMaterialApp extends StatelessWidget {
  const _CafeMateMaterialApp();

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<CafmateStore>().role == CafmateRole.admin;
    return MaterialApp(
      title: 'CafeMate',
      debugShowCheckedModeBanner: false,
      theme: isAdmin ? _adminTheme : _userTheme,
      home: const AppShell(),
    );
  }
}

final _userTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff8c4a2f),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xfffaf7f2),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Color(0xfffaf7f2),
  ),
  cardTheme: const CardThemeData(
    margin: EdgeInsets.zero,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      borderSide: BorderSide.none,
    ),
  ),
);

final _adminTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xffc77728),
    brightness: Brightness.dark,
    surface: const Color(0xff27211d),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xff171310),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Color(0xff171310),
  ),
  cardTheme: const CardThemeData(
    margin: EdgeInsets.zero,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
  ),
);
