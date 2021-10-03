import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/business_logic/bloc/weather_bloc.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final TextEditingController weatherEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(place: "Ahmedabad"));
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: weatherEditingController,
                decoration: InputDecoration(hintText: "Enter Place"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                weatherBloc.add(
                  GetWeather(
                    place: weatherEditingController.text,
                  ),
                );
              },
              child: Text("Search"),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                Widget widget = Container();
                if (state is WeatherLoading) {
                  widget = Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is WeatherLoaded) {
                  widget = Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      state.weather!.main!.temp.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  );
                }
                if (state is WeatherFailed) {
                  widget = Text("Weather failed");
                }
                return widget;
              },
            ),
          ],
        ),
      ),
    );
  }
}
