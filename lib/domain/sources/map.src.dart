// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart';

abstract class MapSource {
/*   Future<List<PointLatLng>> updateRoute({
    required LocationData cLoc,
    required List<PointLatLng> points,
  }); */

  Future<List<dynamic>> updateParcel({
    required String type,
    required String id,
    String comment = "",
    String from = "",
    String to = "",
  });
}
