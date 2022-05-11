import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/failed.widget.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/completed.widget.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/pending.widget.dart';

class DestinationTabList extends StatelessWidget {
  final int value;
  final AcceptDelivery acceptDelivery;

  DestinationTabList({this.value = 0, required this.acceptDelivery});

  @override
  Widget build(BuildContext context) {
    final started = acceptDelivery.started.isNotEmpty;
    final arrived = acceptDelivery.arrived.isNotEmpty;
    final waiting = acceptDelivery.waiting.isNotEmpty;
    bool isNavigating = started || arrived || waiting;

    if (started) {
      BlocProvider.of<HomeCubit>(context).goto(
        "destination",
        params: {"destination": acceptDelivery.started[0], "started": true},
      );
    }

    if (arrived) {
      BlocProvider.of<HomeCubit>(context).goto(
        "destination",
        params: {
          "destination": acceptDelivery.arrived[0],
          "started": true,
          "arrived": true,
        },
      );
    }

    if (waiting) {
      final destination = acceptDelivery.waiting[0];
      final isPickup = destination.type.toLowerCase().contains("pickup");
      BlocProvider.of<HomeCubit>(context).goto(
        isPickup ? "pickup_delivery" : "proof_of_delivery",
        params: destination,
      );
    }

    return isNavigating
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : DefaultTabController(
            length: 3,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Builder(
                builder: (BuildContext context) {
                  final TabController tabController =
                      DefaultTabController.of(context)!;
                  tabController.animateTo(value);

                  return Scaffold(
                    body: Column(
                      children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: ACCENT,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: DARK,
                            ),
                            labelColor: TEXT_LIGHT,
                            unselectedLabelColor: NEUTRAL_PRIMARY_ACCENT,
                            tabs: [
                              Tab(text: 'Pending'),
                              Tab(text: 'Completed'),
                              Tab(text: 'Failed'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Pending(acceptDelivery.pending),
                              Completed(acceptDelivery.completed),
                              Failed(acceptDelivery.failed),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
