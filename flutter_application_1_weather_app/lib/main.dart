import 'package:flutter/material.dart';
import 'package:flutter_application_1_weather_app/app/weather_app.dart';
import 'package:flutter_application_1_weather_app/bloc_observer.dart';
import 'package:flutter_application_1_weather_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const WeatherApp());
}
