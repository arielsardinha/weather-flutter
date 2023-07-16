import 'package:get_it/get_it.dart';

import 'package:open_weather_map/data/infra/http/provider_open_weather_map.dart';
import 'package:open_weather_map/data/repository/weather/weather_provider_dio_repository.dart';

final getIt = GetIt.instance;

sealed class InitialProvider {
  static void init() {
    getIt.registerSingleton(ProviderOpenweathermap());
    getIt.registerLazySingleton<RepositoryWeather>(
        () => RepositoryWeather(httpImpl: getIt<ProviderOpenweathermap>()));
        
  }
}
