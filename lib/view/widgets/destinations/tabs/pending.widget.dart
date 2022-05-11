import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/empty_tab.widget.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/tab_content.widget.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/view/bloc/home/home.cubit.dart';
import 'package:promdifarm_app/view/widgets/destinations/destination_card.widget.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';
import 'package:collection/collection.dart';

class Pending extends StatelessWidget {
  final List<Destination> pending;
  Pending(this.pending);

  @override
  Widget build(BuildContext context) {
    List<Widget> routes = pending.mapIndexed((index, destination) {
      if (index == 0) {
        return OnGoingDestination(
          destination: destination,
          onTap: () {
            BlocProvider.of<HomeCubit>(context).goto(
              "destination",
              params: {"destination": destination},
            );
          },
          title: destination.type.toLowerCase().contains('pickup')
              ? 'pickup'
              : 'delivery',
        );
      }

      return PendingDestination(destination: destination);
    }).toList();

    return Scaffold(
      bottomNavigationBar: routes.length == 0
          ? Container(
              margin: EdgeInsets.only(bottom: 10),
              child: PrimaryButton(
                text: "END CURRENT SESSION",
                onPressed: () {
                  BlocProvider.of<HomeCubit>(context).goto("end_delivery");
                },
              ),
            )
          : Container(height: 0),
      body: routes.length == 0
          ? EmptyTab(
              imageUrl: IMAGE.EMPTY_PENDING_DELIVERY,
              title: "Congrats!!!",
              titleSize: 25,
              subtitle:
                  "You manage to finished all your deliveries.\nClick the button below to end your current shift and get new orders.",
            )
          : TabContent(routes),
    );
  }
}
