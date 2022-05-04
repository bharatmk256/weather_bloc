import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/get_weather_bloc.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final TextEditingController weatherEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final getWeatherBloc = BlocProvider.of<GetWeatherBloc>(context);
    getWeatherBloc.add(GetWeather(place: "Ahmedabad"));
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
                getWeatherBloc.add(
                  GetWeather(
                    place: weatherEditingController.text,
                  ),
                );
              },
              child: Text("Search"),
            ),
            BlocBuilder<GetWeatherBloc, GetWeatherState>(
              builder: (context, state) {
                Widget widget = Container();
                if (state is GetWeatherLoading) {
                  widget = Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetWeatherLoaded) {
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
                if (state is GetWeatherFailed) {
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
