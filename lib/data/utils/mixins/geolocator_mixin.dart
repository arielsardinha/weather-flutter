// ignore_for_file: non_constant_identifier_names

import 'package:geolocator/geolocator.dart';
import 'package:localization/localization.dart';

mixin GeolocatorMixin {
  final POSITION_DEFAULT_ERRO = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('location_service_disabled'.i18n());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('location_permission_denied'.i18n());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('location_permission_denied_forever'.i18n());
    }

    return Geolocator.getCurrentPosition();
  }
}
