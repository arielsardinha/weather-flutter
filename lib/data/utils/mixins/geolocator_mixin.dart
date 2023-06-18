// ignore_for_file: non_constant_identifier_names

import 'package:geolocator/geolocator.dart';

mixin GeolocatorMixin {
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
