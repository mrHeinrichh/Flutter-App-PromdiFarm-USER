import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectionsService {
  List<LatLng> _waypoints = [];

  get waypoints => _waypoints;

  Future<bool> launchGoogleMap({
    required LatLng origin,
    required LatLng destination,
    List<LatLng> waypoints = const [],
  }) async {
    _waypoints = waypoints;
    String origParam = _createLocParam('origin', origin);
    String destParam = _createLocParam('destination', destination);
    String wpParam = _createWayPointString(_waypoints);
    String mapsAPI = 'https://www.google.com/maps/dir/?api=1';
    String travelMode = 'travelmode=driving&dir_action=navigate';
    final _url =
        Uri.parse('$mapsAPI&$origParam&$destParam&$wpParam&$travelMode');
    return launch(_url.toString());
  }

  _createWayPointString(List<LatLng> waypoints) {
    List<String> _waypoints = [];

    waypoints.forEach(
      (waypoint) => _waypoints.add(_createLatLngString(waypoint)),
    );

    return 'waypoints=${_waypoints.join('|')}';
  }

  _createLatLngString(LatLng latLng) {
    String lat = latLng.latitude.toString();
    String lng = latLng.longitude.toString();
    return '$lat,$lng';
  }

  _createLocParam(String prefix, LatLng latLng) {
    return '$prefix=${_createLatLngString(latLng)}';
  }
}
