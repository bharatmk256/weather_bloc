import 'package:weather_bloc/data/model/weather_model.dart';
import 'package:dio/dio.dart';

class WeatherApi {
  static Future<Weather?> getWeather(String place) async {
    try {
      const token = "d27c49560b2aaf8a9303a7f8801a96f3";
      String requestUrl =
          "https://api.openweathermap.org/data/2.5/weather?q=$place&appid=$token";
      Response response = await Dio().get(requestUrl);
      if (response.statusCode == 200) {
        return weatherFromJson(response.toString());
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
}
