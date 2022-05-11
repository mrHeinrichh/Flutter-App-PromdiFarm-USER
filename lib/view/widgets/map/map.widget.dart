import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/data/models/accept_delivery.model.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:promdifarm_app/core/di/index.dart';
// import 'package:promdifarm_app/view/bloc/button/button.cubit.dart';
// import 'package:promdifarm_app/view/bloc/index.dart';
// import 'package:location/location.dart';

class MapBuilder extends StatelessWidget {
  // final double _zoom = 8;
  final AcceptDelivery delivery;

  MapBuilder({
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return Container();

    /*
    MapCubit bloc = sl<MapCubit>();

    BlocListener<ButtonCubit, ButtonState>(
      listener: (context, state) async {
        if (state is FloatingButtonInActive) {
          Location location = new Location();
          LocationData _locationData = await location.getLocation();
          bloc.resetCamera(_locationData);
        }
      },
      child: BlocProvider<MapCubit>(
        create: (BuildContext context) => bloc,
        child: BlocConsumer<MapCubit, MapState>(
          listenWhen: (previous, state) {
            return !(state is MapUpdated || state is MapIdle);
          },
          listener: (context, state) {
            if (state is MapInitController) {
              bloc.listenToLocationChanged();
            }
          },
          buildWhen: (previous, state) {
            return !(state is MapInitial || state is MapIdle);
          },
          builder: (context, state) {
            if (state is MapInitial) {
              bloc.init(delivery: delivery);
            }

            return GoogleMap(
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              buildingsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  delivery.polyline.elementAt(0).latitude,
                  delivery.polyline.elementAt(0).longitude,
                ),
                zoom: _zoom,
              ),
              markers: Set.from(state.markers),
              polylines: Set.from(_setPolyline(state.points)),
              compassEnabled: false,
              minMaxZoomPreference: MinMaxZoomPreference(12, state.zoom),
              onMapCreated: (controller) {
                try {
                  bloc.initController(controller: controller);
                  controller.dispose();
                } catch (e) {
                  print(e);
                }
              },
              onTap: (LatLng latLng) {
                BlocProvider.of<ButtonCubit>(context).isClick();
              },
            );
          },
        ),
      ),
    ); */
  }

  // List<Polyline> _setPolyline(List<PointLatLng> points) {
  //   List<Polyline> _polyline = [];
  //   int _polylineIdCounter = 1;
  //   final String polylineIdVal = 'polyline_$_polylineIdCounter';

  //   _polylineIdCounter++;
  //   _polyline.add(
  //     Polyline(
  //       polylineId: PolylineId(polylineIdVal),
  //       width: 20,
  //       color: Colors.green,
  //       points: points
  //           .map(
  //             (point) => LatLng(point.latitude, point.longitude),
  //           )
  //           .toList(),
  //     ),
  //   );

  //   return _polyline;
  // }
}
