import 'dart:async';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';

abstract class LocationLocalDataSource {
  Future<Position> getCurrentLocation();
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    log("Checking if location services are enabled.");
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log("Location services are disabled.");
      return Future.error('Location services are disabled.');
    }

    log("Checking location permission.");
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      log("Location permission is denied, requesting permission.");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("Location permission was denied by the user.");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log("Location permission is permanently denied.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    log("Permission granted, fetching current position with a 15-second timeout.");
    try {
      return await Geolocator.getCurrentPosition()
          .timeout(const Duration(seconds: 15));
    } on TimeoutException {
      log("TimeoutException: Could not fetch location within 15 seconds.");
      return Future.error(
          'Could not get location in time. Please ensure you have a clear GPS signal and try again.');
    } catch (e) {
      log("An unexpected error occurred while fetching position: $e");
      return Future.error('An unexpected error occurred while fetching location.');
    }
  }
}
