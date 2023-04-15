import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheather_app/Pages/home.dart';
import 'package:wheather_app/theme/weather_theme.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: WeatherTheme.lightTheme,
      darkTheme: WeatherTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}