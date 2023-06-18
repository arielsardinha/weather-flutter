// ignore_for_file: must_be_immutable
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:open_weather_map/app/components/buttons/custon_text_form_field.dart';
import 'package:open_weather_map/data/blocs/weather/weather_bloc.dart';
import 'package:open_weather_map/data/blocs/weather/weather_events.dart';
import 'package:open_weather_map/data/blocs/weather/weather_states.dart';
import 'package:open_weather_map/data/entities/lat_lng.dart';
import 'package:open_weather_map/data/entities/weather.dart';
import 'package:open_weather_map/data/utils/mixins/debounce_mixin.dart';
import 'package:open_weather_map/data/utils/mixins/geolocator_mixin.dart';

class HomeView extends StatefulWidget {
  final WeatherBloc bloc;
  const HomeView({super.key, required this.bloc});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with DebouncerMixin, GeolocatorMixin {
  final _focusNode = FocusNode();
  final textCtl = TextEditingController();

  @override
  void initState() {
    getWeatherByLatLng();
    super.initState();
  }

  Future<void> getWeatherByLatLng() async {
    try {
      final position = await determinePosition();
      final latLng = LatLng(lat: position.latitude, lng: position.longitude);
      widget.bloc.inputWeather.add(WeatherLoadEvent(latLong: latLng));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ative a localização do dispositivo'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    widget.bloc.inputWeather.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: StreamBuilder<WeatherState>(
          stream: widget.bloc.stream,
          builder: (context, snapshot) {
            final weather = snapshot.data?.weather;

            return Stack(
              children: [
                if (weather != null)
                  Image.network(
                    'https://source.unsplash.com/featured/?${weather.weather[0].description}',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustonTextFormField(
                          focusNode: _focusNode,
                          controller: textCtl,
                          onChanged: (value) {
                            debounce(() {
                              widget.bloc.inputWeather
                                  .add(WeatherLoadEvent(message: value));
                              if (value.isNotEmpty) {
                                _focusNode.unfocus();
                              }
                            }, cancel: value.isEmpty);
                          },
                          label: 'Digite uma cidade...',
                          suffixIcon: IconButton(
                            onPressed: () {
                              getWeatherByLatLng();
                              textCtl.clear();
                            },
                            icon: Icon(
                              Icons.location_on_outlined,
                              color: theme.colorScheme.primary,
                            ),
                          ),
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
                          InfoText(msg: err),
                        WeatherSuccessState(weather: final weather!) =>
                          InfoWeather(weather: weather),
                        WeatherInitialState() => const InfoText(
                            msg:
                                'Por favor, digite uma cidade para ver o clima.'),
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

class InfoText extends StatelessWidget {
  final String msg;
  const InfoText({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        msg,
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: theme.textTheme.titleMedium,
              ),
              if (weather.sys.country != null)
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
                'https://openweathermap.org/img/wn/${weather.weather[0].icon}.png',
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "${weather.main.temp?.toStringAsFixed(1)}°C",
            style: theme.textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}
