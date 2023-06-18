import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:open_weather_map/app/components/buttons/custon_text_form_field.dart';
import 'package:open_weather_map/app/components/layout/custon_drawer.dart';
import 'package:open_weather_map/data/blocs/forecast/forecast_bloc.dart';
import 'package:open_weather_map/data/blocs/forecast/forecast_event.dart';
import 'package:open_weather_map/data/blocs/forecast/forecast_state.dart';
import 'package:open_weather_map/data/blocs/weather/weather_bloc.dart';
import 'package:open_weather_map/data/blocs/weather/weather_events.dart';
import 'package:open_weather_map/data/blocs/weather/weather_states.dart';
import 'package:open_weather_map/data/entities/forecast.dart';
import 'package:open_weather_map/data/entities/lat_lng.dart';
import 'package:open_weather_map/data/entities/weather.dart';
import 'package:open_weather_map/data/utils/mixins/date_formate.dart';
import 'package:open_weather_map/data/utils/mixins/debounce_mixin.dart';
import 'package:open_weather_map/data/utils/mixins/geolocator_mixin.dart';

class HomeView extends StatefulWidget {
  final WeatherBloc weatherBloc;
  final ForecastBloc forecastBloc;
  const HomeView(
      {Key? key, required this.weatherBloc, required this.forecastBloc})
      : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with DebouncerMixin, GeolocatorMixin {
  final _focusNode = FocusNode();
  final textCtl = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String getDayPart() {
    var hour = DateTime.now().hour;
    if (hour < 6) {
      return "night";
    } else if (hour < 12) {
      return "morning";
    } else if (hour < 18) {
      return "afternoon";
    } else {
      return "night";
    }
  }

  @override
  void initState() {
    (() async {
      final position =
          await determinePosition().whenComplete(() => POSITION_DEFAULT_ERRO);
      if (position == POSITION_DEFAULT_ERRO) return;
      final latLng = LatLng(lat: position.latitude, lng: position.longitude);
      widget.weatherBloc.input.add(WeatherLoadEvent(latLong: latLng,units: ''));
      widget.forecastBloc.input.add(ForecastLoadEvent(latLng: latLng,units: ''));
    })();
    super.initState();
  }

  Future<void> getWeatherByLatLng() async {
    try {
      final position = await determinePosition();
      final latLng = LatLng(lat: position.latitude, lng: position.longitude);
      widget.weatherBloc.input.add(WeatherLoadEvent(latLong: latLng,units: ''));
      widget.forecastBloc.input.add(ForecastLoadEvent(latLng: latLng,units: ''));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('device_location_error'.i18n()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    widget.weatherBloc.dispose();
    widget.forecastBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustonDrawer(),
      body: StreamBuilder<WeatherState>(
        stream: widget.weatherBloc.stream,
        builder: (context, snapshot) {
          return Stack(
            children: [
              if (snapshot.data is WeatherSuccessState)
                switch (snapshot.data) {
                  WeatherSuccessState(weather: final weather) => Image.network(
                      'https://source.unsplash.com/featured/?${weather.weather[0].description},${getDayPart()},landscape',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  _ => const SizedBox()
                },
              SafeArea(
                child: ListView(
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
                            widget.weatherBloc.input
                                .add(WeatherLoadEvent(message: value,units: ''));
                            if (snapshot.data is WeatherSuccessState) {
                              final weather =
                                  snapshot.data as WeatherSuccessState;
                              final LatLng latLng = LatLng(
                                  lat: weather.weather.coord.lat,
                                  lng: weather.weather.coord.lon);
                              widget.forecastBloc.input
                                  .add(ForecastLoadEvent(latLng: latLng,units: ''));
                            }

                            if (value.isNotEmpty) {
                              _focusNode.unfocus();
                            }
                          }, cancel: value.isEmpty);
                        },
                        label: '${'enter_city'.i18n()}...',
                        prefixIcon: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await getWeatherByLatLng();
                            textCtl.clear();
                            _focusNode.unfocus();
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
                      WeatherInitialState() =>
                        InfoText(msg: 'initial_message'.i18n()),
                      WeatherSuccessState(weather: final weather) =>
                        InfoWeather(weather: weather),
                      WeatherLoadState() || _ => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                    },
                    StreamBuilder<ForecastState>(
                      stream: widget.forecastBloc.stream,
                      builder: (context, snapshot) {
                        return switch (snapshot.data) {
                          ForecastErrorState(message: final err) =>
                            InfoText(msg: err),
                          ForecastSuccessState(forecast: final forecast) =>
                            InfoForecast(forecast: forecast),
                          ForecastInitialState() ||
                          ForecastLoadState() ||
                          _ =>
                            const SizedBox(),
                        };
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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

class InfoWeather extends StatelessWidget with DateFormatMixin {
  final Weather weather;

  const InfoWeather({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = DateTime.now();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.background.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.onBackground,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatDateFromDateTime(today),
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
                    "${'humidity'.i18n()}: ${weather.main.humidity}%",
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
                    "${'wind'.i18n()}: ${weather.wind.speed} m/s",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.visibility,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "${'visibility'.i18n()}: ${weather.visibility}",
                    style: theme.textTheme.titleMedium,
                  ),
                  PopupMenuButton(
                    icon: Icon(
                      Icons.error,
                      color: theme.colorScheme.primary,
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text(weather.visibilityMessage),
                        ),
                      ];
                    },
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
                weather.weather[0].description,
                style: theme.textTheme.titleLarge,
              ),
              Image.network(
                'https://openweathermap.org/img/wn/${weather.weather[0].icon}.png',
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "${weather.main.temp?.toStringAsFixed(1) ?? '-'}°C",
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          if (weather.main.tempMin != null && weather.main.tempMax != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${'min'.i18n()}: ${weather.main.tempMin?.toStringAsFixed(1)}°C",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(width: 16),
                Text(
                  "${'max'.i18n()}: ${weather.main.tempMax?.toStringAsFixed(1)}°C",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class InfoForecast extends StatelessWidget {
  final Forecast forecast;

  const InfoForecast({Key? key, required this.forecast}) : super(key: key);

  String getDayOfWeek(int timeStamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('EEEE').format(date).toLowerCase().i18n();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.background.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.onBackground,
          width: 1,
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.afternoonForecasts.length,
        itemBuilder: (context, index) {
          final forecastItem = forecast.afternoonForecasts[index];
          final isFirst = forecastItem == forecast.afternoonForecasts.first;
          final isLast = forecastItem == forecast.afternoonForecasts.last;
          return Padding(
            padding: EdgeInsets.only(
              right: isFirst ? 8 : 16,
              left: isLast ? 8 : 16,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  getDayOfWeek(forecastItem.dt),
                  style: theme.textTheme.titleSmall,
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/${forecastItem.weather[0].icon}.png',
                ),
                Row(
                  children: [
                    Text(
                      '${forecastItem.main.tempMin.toStringAsFixed(0)}°',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${forecastItem.main.tempMax.toStringAsFixed(0)}°',
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
