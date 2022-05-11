import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';
import 'package:promdifarm_app/view/widgets/destinations/pickup/pickup_card.dart';
import 'package:promdifarm_app/view/widgets/modal.widget.dart';

class PickUpList extends StatelessWidget {
  final Destination destination;

  PickUpList(this.destination);

  @override
  Widget build(BuildContext context) {
    final pickupListBloc = sl<PickUpListCubit>();
    pickupListBloc.init(destination.parcels);

    return BlocProvider(
      create: (BuildContext context) => pickupListBloc,
      child: Scaffold(
        backgroundColor: NEUTRAL_PRIMARY_ACCENT,
        bottomNavigationBar: BlocConsumer<PickUpListCubit, PickUpListState>(
          listener: (context, state) {
            if (state is FinishPickup) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext ctx) {
                  return LoadingModal(
                    title: "Finishing Pickup",
                    subtitle:
                        "Please wait while we are processing your items...",
                  );
                },
              );
            }

            if (state is AcceptItem || state is CancelItem) {
              final isAccept = state is AcceptItem;
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext ctx) {
                  return LoadingModal(
                    title: "${isAccept ? 'Accepting' : 'Canceling'} Item",
                    subtitle:
                        "Please wait while we are updating parcel details...",
                  );
                },
              );
            }

            if (state is FinishPickupSuccess ||
                state is FinishPickupFail ||
                state is CancelItemSuccess ||
                state is AcceptItemSuccess) {
              Timer(
                Duration(seconds: 2),
                () {
                  Navigator.pop(context);

                  if (state is FinishPickupSuccess) {
                    BlocProvider.of<HomeCubit>(context).goto(
                      "done_pickup",
                      params: state.acceptDelivery,
                    );
                  }
                },
              );
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(10),
              child: BlocBuilder<PickUpListCubit, PickUpListState>(
                builder: (context, pickupListState) {
                  return pickupListState.parcels.length == 0
                      ? PrimaryButton(
                          text: "FINISH PICKUP",
                          onPressed: () {
                            BlocProvider.of<DeliveriesCubit>(context)
                                .updateDestinationStatus(
                              destinations: [destination.id],
                              status: "Completed",
                            );
                            pickupListBloc.finishPickUp(destination);
                          },
                        )
                      : GrayButton(text: "FINISH PICKUP", onPressed: () {});
                },
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(18, 20, 18, 0),
            child: BlocBuilder<PickUpListCubit, PickUpListState>(
              buildWhen: (context, state) {
                return !(state is AcceptItem);
              },
              builder: (context, pickupListState) {
                final parcels = pickupListState.parcels.length >= 0
                    ? pickupListState.parcels
                    : destination.parcels;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: parcels.map((e) => PickUpCard(e)).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
