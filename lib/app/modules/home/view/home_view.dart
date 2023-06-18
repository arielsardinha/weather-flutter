// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:open_weather_map/data/blocs/weather/weather_bloc.dart';
import 'package:open_weather_map/data/blocs/weather/weather_events.dart';
import 'package:open_weather_map/data/blocs/weather/weather_states.dart';
import 'package:open_weather_map/data/entities/weather.dart';
import 'package:open_weather_map/data/utils/mixins/debounce_mixin.dart';

class HomeView extends StatefulWidget {
  final WeatherBloc bloc;
  const HomeView({super.key, required this.bloc});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with DebouncerMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.bloc.inputWeather.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              debounce(() {
                widget.bloc.inputWeather.add(WeatherLoadEvent(message: value));
              }, cancel: value.isEmpty);
            },
            decoration: const InputDecoration(
              label: Text('Digite uma cidade...'),
            ),
          ),
          Center(
            child: StreamBuilder<WeatherState>(
              stream: widget.bloc.stream,
              builder: (context, snapshot) {
                return switch (snapshot.data) {
                  WeatherErroState(message: final m) => Text(m),
                  WeatherSuccessState(weather: final weather!) =>
                    MyWidget(weather: weather),
                  WeatherInitialState() => const SizedBox(),
                  _ => const CircularProgressIndicator.adaptive(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final Weather weather;

  const MyWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Text(weather.name);
  }
}
