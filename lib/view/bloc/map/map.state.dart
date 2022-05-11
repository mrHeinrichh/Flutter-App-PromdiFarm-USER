part of 'map.cubit.dart';

@immutable
abstract class MapState {
  final List<Marker> markers;
  final List<PointLatLng> points;
  late final GoogleMapController controller;
  final double zoom;
  final double tilt;
  final bool isClicked;

  MapState({
    this.markers = const [],
    this.points = const [],
    this.zoom = 20,
    this.tilt = 90,
    this.isClicked = false,
  });
}

class MapInitial extends MapState {}

class MapFail extends MapState {
  MapFail(msg);
}

class MapInitialized extends MapState {
  MapInitialized({points, markers, zoom, tilt})
      : super(
          markers: markers,
          points: points,
          zoom: zoom,
          tilt: tilt,
        );
}

class MapUpdated extends MapState {
  final GoogleMapController controller;

  MapUpdated({required this.controller, points, markers, zoom, tilt, isClicked})
      : super(
          markers: markers,
          points: points,
          zoom: zoom,
          tilt: tilt,
          isClicked: isClicked,
        );
}

class MapIdle extends MapState {
  final GoogleMapController controller;

  MapIdle({required this.controller, points, markers, zoom, tilt, isClicked})
      : super(
          markers: markers,
          points: points,
          zoom: zoom,
          tilt: tilt,
          isClicked: isClicked,
        );
}

class MapInitController extends MapState {
  final GoogleMapController controller;

  MapInitController({
    required this.controller,
    points,
    markers,
    zoom,
    tilt,
    isClicked,
  }) : super(
          markers: markers,
          points: points,
          zoom: zoom,
          tilt: tilt,
          isClicked: isClicked,
        );
}
