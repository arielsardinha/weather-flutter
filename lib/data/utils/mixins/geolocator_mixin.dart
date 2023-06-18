// ignore_for_file: non_constant_identifier_names

import 'package:geolocator/geolocator.dart';

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
      return Future.error("locationServicesAreDisabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("locationPermissionsAreDenied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'locationPermissionsArePermanentlyDeniedWeCannotRequestPermissions');
    }
    return Geolocator.getCurrentPosition();
  }
}
