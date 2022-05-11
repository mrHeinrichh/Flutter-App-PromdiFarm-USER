import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/view/bloc/button/button.cubit.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
// import 'package:promdifarm_app/view/widgets/floating_button.widget.dart';
// import 'package:promdifarm_app/view/widgets/map/map.widget.dart';
// import 'package:promdifarm_app/view/widgets/map/destination_dropdown.widget.dart';

class MapPage extends StatelessWidget {
  final String id;

  MapPage({required this.id});

  @override
  Widget build(BuildContext context) {
    final ButtonCubit buttonBloc = sl<ButtonCubit>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocProvider<ButtonCubit>(
        create: (BuildContext context) => buttonBloc,
        child: BlocBuilder<DeliveriesCubit, DeliveriesState>(
          builder: (context, state) {
            // if (state is DeliveriesInitial) {
            //   BlocProvider.of<DeliveriesCubit>(context).acceptDelivery(id: id);
            // }

            /*     if (state is AcceptDeliverySuccess &&
                state.delivery.destinations.length != 0) {
              return Scaffold(
                floatingActionButton: Visibility(
                  visible: true,
                  child: RefreshGreenFloatingButton(),
                ),
                body: Stack(
                  children: [
                    MapBuilder(delivery: state.delivery),
                    DestinationDropdown(
                      destinations: state.delivery.destinations,
                    ),
                  ],
                ),
              );
            } */

            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  Marker addMarker({
    required LatLng latLong,
    required String title,
    String description = "",
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
  }) {
    MarkerId markerId = MarkerId(title);
    return Marker(
      markerId: markerId,
      position: latLong,
      infoWindow: InfoWindow(title: title, snippet: description),
      icon: icon,
      onTap: () {},
    );
  }
}
