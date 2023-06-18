sealed class WeatherEvent {}

final class WeatherLoadEvent extends WeatherEvent {
  final String message;

  WeatherLoadEvent({required this.message});
}
