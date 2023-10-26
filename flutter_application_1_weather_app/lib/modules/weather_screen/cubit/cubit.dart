// import 'dart:developer';

import 'package:flutter_application_1_weather_app/modules/weather_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/current_weather_model.dart';
import '../../../model/forecast_weather_model.dart';
import '../../../shared/network/remote/dio_helper.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitialState());
  static WeatherCubit get(context) => BlocProvider.of(context);

  String city = "amman";
  CurrentWeatherM? currentModel;
  ForecastWeatherM? forecastModel;
  List<num>? sundayList;

  void getWeather({
    //String? city,
    String appid = "5b5585b0fb7a63af4fc2ed8a151ca6bd",
  }) {
    emit(WeatherLoadingState());
    DioHelper.getData(
      url: "/weather",
      query: {'q': city, 'appid': appid},
    ).then((value) {
      print(value.data.toString());
      currentModel = CurrentWeatherM.fromMap(value.data);
      print("temp:${currentModel?.main?.temp}");
      emit(WeatherSuccessState());
    }).catchError((error) {
      emit(WeatherErrorState());
      print(error.data.toString());
    });
  }

  void getForecastWeather({
    //String city = "amman",
    String appid = "5b5585b0fb7a63af4fc2ed8a151ca6bd",
  }) {
    emit(ForeCastWeatherLoadingState());
    DioHelper.getData(
      url: "/forecast",
      query: {'q': city, 'appid': appid},
    ).then((value) {
      emit(ForeCastWeatherSuccessState());
      forecastModel = ForecastWeatherM.fromMap(value.data);
      print("status:${forecastModel?.cod}");
    }).catchError((error) {
      emit(ForeCastWeatherErrorState());
      print(error.data.toString());
    });
  }
}
