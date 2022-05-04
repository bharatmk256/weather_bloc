part of 'get_weather_bloc.dart';

@immutable
abstract class GetWeatherEvent {}
class GetWeather extends GetWeatherEvent {
  final String place;
  GetWeather({required this.place});
}
