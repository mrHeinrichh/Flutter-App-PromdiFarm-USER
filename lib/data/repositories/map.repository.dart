// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/domain/repositories/map.repo.dart';
import 'package:promdifarm_app/domain/sources/map.src.dart';

class MapRepositoryImp extends MapRepository {
  final MapSource source;

  MapRepositoryImp(this.source);

/*   @override
  updateRoute({
    required LocationData cLoc,
    required List<PointLatLng> points,
  }) {
    return ErrorHandler.async<List<PointLatLng>>(
      source.updateRoute(cLoc: cLoc, points: points),
    );
  } */

  @override
  updateParcel({
    required String type,
    required String id,
    String comment = "",
    String from = "",
    String to = "",
  }) {
    return ErrorHandler.async<List<dynamic>>(
      source.updateParcel(
        type: type,
        id: id,
        comment: comment,
        from: from,
        to: to,
      ),
    );
  }
}
