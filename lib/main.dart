import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';

/// Titik masuk utama aplikasi Flutter MyPortfolio Mobile.
void main() {
  runApp(const MyApp());
}

/// Root widget aplikasi yang mengonfigurasi tema Material 3 dan halaman utama.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E3A8A),
      secondary: const Color(0xFFD95D39),
    );

    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFFAF6F0),
        cardTheme: const CardThemeData(
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
