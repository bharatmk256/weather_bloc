part of 'get_weather_bloc.dart';

@immutable
abstract class GetWeatherState {}

class GetWeatherInitial extends GetWeatherState {}

class GetWeatherLoading extends GetWeatherState {}

class GetWeatherLoaded extends GetWeatherState {
  final Weather? weather;
  GetWeatherLoaded({this.weather});
}

class GetWeatherFailed extends GetWeatherState {}
