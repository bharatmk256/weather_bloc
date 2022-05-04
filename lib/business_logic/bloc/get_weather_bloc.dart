import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_bloc/data/dataproviders/network/weather_api.dart';

import '../../data/model/weather_model.dart';

part 'get_weather_event.dart';
part 'get_weather_state.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  GetWeatherBloc() : super(GetWeatherInitial()) {
    on<GetWeatherEvent>(
      (event, emit) async {
        if (event is GetWeather) {
          emit(GetWeatherLoading());
          Weather? weather = await WeatherApi.getWeather(event.place);
          if (weather == null) {
            emit(GetWeatherFailed());
          } else if (weather.weather!.isNotEmpty) {
            emit(GetWeatherLoaded(weather: weather));
          } else {
            emit(GetWeatherFailed());
          }
        }
      },
    );
  }
}
