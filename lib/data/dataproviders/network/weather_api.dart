import 'package:weather_bloc/data/model/weather_model.dart';
import 'package:dio/dio.dart';

import '../../../token.dart';

class WeatherApi {
  static Future<Weather?> getWeather(String place) async {
    try {
      
      String requestUrl =
          "https://api.openweathermap.org/data/2.5/weather?q=$place&appid=$TOKEN";
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
