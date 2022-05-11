import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = new Location();
  bool hasInitialized = false;

  init() async {
    if (hasInitialized) return;

    bool _serviceEnabled = await _isServiceEnabled(location);
    PermissionStatus _permission = await _isPermissionGranted(location);

    if (_serviceEnabled || _permission == PermissionStatus.granted) {
      location.enableBackgroundMode(enable: true);
      hasInitialized = true;
    }
  }

  Future<LatLng> getCurrentLocation() async {
    LocationData _locationData = await location.getLocation();
    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  Future<PermissionStatus> _isPermissionGranted(Location location) async {
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied)
      _permissionGranted = await location.requestPermission();
    return _permissionGranted;
  }

  Future<bool> _isServiceEnabled(Location location) async {
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();
    return _serviceEnabled;
  }
}
