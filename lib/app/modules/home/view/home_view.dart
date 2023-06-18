// ignore_for_file: must_be_immutable
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:open_weather_map/app/components/buttons/custon_text_form_field.dart';
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
  void dispose() {
    widget.bloc.inputWeather.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<WeatherState>(
          stream: widget.bloc.stream,
          builder: (context, snapshot) {
            final weather = snapshot.data?.weather;

            return Stack(
              children: [
                Image.network(
                  'https://source.unsplash.com/featured/?${weather?.weather[0].description ?? 'doubt'}',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustonTextFormField(
                          onChanged: (value) {
                            debounce(() {
                              widget.bloc.inputWeather
                                  .add(WeatherLoadEvent(message: value));
                            }, cancel: value.isEmpty);
                          },
                          label: 'Digite uma cidade...',
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      switch (snapshot.data) {
                        WeatherErroState(message: final err) =>
                          InfoErro(erro: err),
                        WeatherSuccessState(weather: final weather!) =>
                          InfoWeather(weather: weather),
                        WeatherInitialState() => const SizedBox(),
                        WeatherLoadState() ||
                        _ =>
                          const CircularProgressIndicator.adaptive(),
                      },
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class InfoErro extends StatelessWidget {
  final String erro;
  const InfoErro({super.key, required this.erro});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        erro,
        style: theme.textTheme.titleMedium,
      ),
    );
  }
}

class InfoWeather extends StatelessWidget {
  final Weather weather;

  const InfoWeather({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = DateTime.now();

    final formattedDate = DateFormat('EEEE, d MMM, yyyy').format(today);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: theme.textTheme.titleMedium,
              ),
              Row(
                children: [
                  Text(
                    weather.name,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(width: 16),
                  Image.network(
                    "https://flagsapi.com/${weather.sys.country}/flat/64.png",
                    width: 25,
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.water_drop_outlined,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Humidity: ${weather.main.humidity}%",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.air,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Wind: ${weather.wind.speed} m/s",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${weather.weather[0].main}: ${weather.weather[0].description}",
                style: theme.textTheme.titleLarge,
              ),
              Image.network(
                  'https://openweathermap.org/img/wn/${weather.weather[0].icon}.png')
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "${weather.main.temp.toStringAsFixed(1)}°C",
            style: theme.textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}
