import 'package:flutter/material.dart';
import 'package:flutter_application_1_weather_app/modules/weather_screen/cubit/cubit.dart';
import 'package:flutter_application_1_weather_app/shared/style/theme/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/weather_screen/weather_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()
        ..getForecastWeather()
        ..getWeather(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: home(),
        darkTheme: darkTheme,
        theme: lightTheme,
        // themeMode: ThemeMode.light,
      ),
    );
  }
}

Widget home() {
  return WeatherScreen();
}
