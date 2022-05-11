import 'package:bloc/bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:promdifarm_app/data/models/accept_delivery.model.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
part 'map.state.dart';

class MapCubit extends Cubit<MapState> {
  final MapRepository repository;
  final Location location = new Location();

  List<PointLatLng> _points = [];
  List<Destination> _destinations = [];

  MapCubit({required this.repository}) : super(MapInitial());

  Future<void> init({
    required AcceptDelivery delivery,
    double zoom = 20,
    double tilt = 90,
  }) async {
    /*   _points = delivery.polyline;
    List<Marker> markers = [];

    LatLng initialPosition = LatLng(
      _points.first.latitude,
      _points.first.longitude,
    );

    Marker riderMark = addMarker(
      latLong: initialPosition,
      title: "Rider 1",
      icon: delivery.rider,
      rotation: -45,
    );

    markers.add(riderMark); */

    // _destinations = delivery.destinations;

    // delivery.destinations.forEach(
    //   (item) {
    //     bool isPickup = item.type == "PickupAddress";
    //     Marker marker = addMarker(
    //       latLong: LatLng(
    //         item.loc.coordinates[1],
    //         item.loc.coordinates[0],
    //       ),
    //       title: item.title,
    //       icon: isPickup ? delivery.outlet : delivery.dropoff,
    //     );
    //     markers.add(marker);
    //   },
    // );

    /*   emit(
      MapInitialized(
        points: _points,
        markers: markers,
        zoom: zoom,
        tilt: tilt,
      ),
    ); */
  }

  initController({required GoogleMapController controller}) {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      controller.setMapStyle(string);
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              state.points.first.latitude,
              state.points.first.longitude,
            ),
            zoom: state.zoom,
            tilt: state.tilt,
          ),
        ),
      );
      emit(
        MapInitController(
          points: state.points,
          markers: state.markers,
          controller: controller,
          zoom: state.zoom,
          tilt: state.tilt,
          isClicked: state.isClicked,
        ),
      );
      controller.dispose();
    });
  }

  isIdle() {
    emit(
      MapIdle(
        points: state.points,
        markers: state.markers,
        controller: state.controller,
        zoom: state.zoom,
        tilt: state.tilt,
        isClicked: state.isClicked,
      ),
    );
  }

  isClick() {
    emit(
      MapUpdated(
        points: state.points,
        markers: state.markers,
        controller: state.controller,
        zoom: state.zoom,
        tilt: state.tilt,
        isClicked: true,
      ),
    );
  }

  resetCamera(LocationData cLoc) {
    state.controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            cLoc.latitude!,
            cLoc.longitude!,
          ),
          zoom: state.zoom,
          tilt: state.tilt,
          bearing: cLoc.heading!,
        ),
      ),
    );

    emit(
      MapUpdated(
        points: state.points,
        markers: state.markers,
        controller: state.controller,
        zoom: state.zoom,
        tilt: state.tilt,
        isClicked: false,
      ),
    );
    state.controller.dispose();
  }

  listenToLocationChanged() {
    location.onLocationChanged.listen((cLoc) {
      bool isLat = state.points.first.latitude.toStringAsFixed(5) ==
          cLoc.latitude!.toStringAsFixed(5);
      bool isLng = state.points.first.longitude.toStringAsFixed(5) ==
          cLoc.longitude!.toStringAsFixed(5);

      this.checkRiderStatus(cLoc);

      if (isLat && isLng)
        return emit(
          MapIdle(
            points: state.points,
            markers: state.markers,
            controller: state.controller,
            zoom: state.zoom,
            tilt: state.tilt,
            isClicked: state.isClicked,
          ),
        );

      if (!state.isClicked) {
        state.controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(cLoc.latitude!, cLoc.longitude!),
              zoom: state.zoom,
              tilt: state.tilt,
              bearing: cLoc.heading! - 15,
            ),
          ),
        );
      }

      Marker marker = state.markers.elementAt(0);
      Marker rider = addMarker(
        latLong: LatLng(cLoc.latitude!, cLoc.longitude!),
        title: "",
        icon: marker.icon,
        rotation: -45,
      );

      state.markers.removeAt(0);
      state.markers.insert(0, rider);

      PointLatLng point = PointLatLng(cLoc.latitude!, cLoc.longitude!);
      mp.LatLng mpPoint = mp.LatLng(point.latitude, point.longitude);

      List<mp.LatLng> poly =
          _points.map((e) => mp.LatLng(e.latitude, e.longitude)).toList();

      int locationIndex10 = mp.PolygonUtil.locationIndexOnEdgeOrPath(
          mpPoint, poly, false, false, 10);

      int locationIndex5 = mp.PolygonUtil.locationIndexOnEdgeOrPath(
          mpPoint, poly, false, false, 5);

      int locationIndex = mp.PolygonUtil.locationIndexOnEdgeOrPath(
          mpPoint, poly, false, false, 1);

      int locIndex = locationIndex10 > locationIndex5
          ? locationIndex10
          : locationIndex5 > locationIndex
              ? locationIndex5
              : locationIndex;
      int plus1 = 0;

      if (locationIndex10 != -1 &&
          locationIndex5 != -1 &&
          locationIndex == -1) {
        PointLatLng to = _points.elementAt(locIndex + 1);
        mp.LatLng toPoint = mp.LatLng(to.latitude, to.longitude);
        num distance =
            mp.SphericalUtil.computeDistanceBetween(mpPoint, toPoint);
        plus1 = distance < 5 ? 1 : 0;
      }

      List<PointLatLng> points =
          _points.getRange(locIndex + 1 + plus1, _points.length).toList();
      points.insert(0, point);

      emit(MapUpdated(
        points: points,
        markers: state.markers,
        controller: state.controller,
        zoom: state.zoom,
        tilt: state.tilt,
        isClicked: state.isClicked,
      ));

      if (locationIndex10 == -1 && locationIndex5 == -1) {
        /*      repository.updateRoute(cLoc: cLoc, points: points).then(
          (res) {
            res.fold(
              (failure) => emit(MapFail(failure)),
              (success) {
                _points = success;
                emit(
                  MapUpdated(
                    points: success,
                    markers: state.markers,
                    controller: state.controller,
                    zoom: state.zoom,
                    tilt: state.tilt,
                    isClicked: state.isClicked,
                  ),
                );
              },
            );
          },
        ); */
      }
    });
  }

  Marker addMarker({
    required LatLng latLong,
    required String title,
    double rotation = 0,
    String description = "",
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
  }) {
    MarkerId markerId = MarkerId(title);
    return Marker(
      markerId: markerId,
      position: latLong,
      infoWindow: InfoWindow(title: "", snippet: description),
      icon: icon,
      rotation: rotation,
      onTap: () {},
    );
  }

  void checkRiderStatus(LocationData cLoc) async {
    _destinations.forEach((e) {
      num distance = mp.SphericalUtil.computeDistanceBetween(
        mp.LatLng(cLoc.latitude!, cLoc.longitude!),
        mp.LatLng(e.loc.coordinates[1], e.loc.coordinates[0]),
      );

      if (distance <= 20) {
        //  Call API update destination status
        print("ARRIVED ${e.parcels}");
      }

      if (distance > 20 && distance <= 100 && e.type.contains("Shipping")) {
        //  Call API update destination status
        print("ARRIVING ${e.parcels}");
      }

      if (distance > 20 && distance <= 100 && e.type.contains("Pickup")) {
        //  Call API update destination status
        print("PICKUP ${e.parcels}");
      }
    });
  }
}
