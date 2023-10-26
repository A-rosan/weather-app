import 'package:dio/dio.dart';

//https://api.openweathermap.org/data/2.5/
// weather?
// q=amman&appid=5b5585b0fb7a63af4fc2ed8a151ca6bd
class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://api.openweathermap.org/data/2.5",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }
}
