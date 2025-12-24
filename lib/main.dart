import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:angryflutter/weather/core/theme/app_theme.dart';
import 'package:angryflutter/weather/presentation/screens/weather_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: AppTheme.darkTheme,
      home: WeatherScreen(),
    );
  }
}
