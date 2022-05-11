import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/core/services/index.dart';
import 'package:promdifarm_app/data/models/response.model.dart';
import 'package:promdifarm_app/domain/sources/map.src.dart';

class MapSourceImp extends MapSource {
  final DirectionsService dirService;
  final ApiService api;

  MapSourceImp({
    required this.dirService,
    required this.api,
  });

  /* @override
  updateRoute({
    required LocationData cLoc,
    required List<PointLatLng> points,
  }) async {
    return this.dirService.getDirections(
          origin: LatLng(
            cLoc.latitude!,
            cLoc.longitude!,
          ),
          waypoints: this.dirService.waypoints,
          destination: LatLng(
            points.last.latitude,
            points.last.longitude,
          ),
        );
  } */

  @override
  Future<List<dynamic>> updateParcel({
    required String type,
    required String id,
    String comment = "",
    String from = "",
    String to = "",
  }) async {
    Response response = await api.patch(
      endpoint: "parcels/$id/tracking",
      body: {type: type, comment: comment, from: from, to: to},
    );

    if (response.status != "success") {
      throw RequestFailure(response.message);
    }

    return response.data;
  }
}
