import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_bloc/data/dataproviders/network/weather_api.dart';
import 'package:weather_bloc/data/model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      yield WeatherLoading();
      Weather? weather = await WeatherApi.getWeather(event.place);
      if (weather == null) {
        yield WeatherFailed();
      } else if (weather.weather!.isNotEmpty) {
        yield WeatherLoaded(weather: weather);
      } else {
        yield WeatherFailed();
      }
    }
  }
}
