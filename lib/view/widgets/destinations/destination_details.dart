import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/view/widgets/destinations/parcel_card.widget.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/view/bloc/deliveries/deliveries.cubit.dart';
import 'package:promdifarm_app/view/bloc/destination_details/destination_details.cubit.dart';
import 'package:promdifarm_app/view/bloc/home/home.cubit.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';
import 'package:promdifarm_app/view/widgets/modal.widget.dart';
import 'package:promdifarm_app/view/widgets/toasts/toast.widget.dart';

class DestinationDetails extends StatelessWidget {
  final Destination destination;
  final bool started;
  final bool arrived;
  final ToastInstance toast = ToastInstance();

  DestinationDetails(
    this.destination, {
    this.started = false,
    this.arrived = false,
  });

  @override
  Widget build(BuildContext context) {
    toast.init(context);
    return BlocConsumer<DestinationDetailsCubit, DestinationDetailsState>(
      listener: (context, state) {
        bool isPickup = destination.type.toLowerCase().contains("pick");
        if (state is DestinationDetailsStarted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext ctx) {
              return LoadingModal(
                title: "Starting ${isPickup ? 'Pickup' : 'Delivery'}",
                subtitle: "Please wait while we are loading the map details...",
              );
            },
          );
        }

        if (state is DestinationDetailsCancel) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext ctx) {
              return LoadingModal(
                title: "Canceling ${isPickup ? 'Pickup' : 'Delivery'}",
                subtitle:
                    "Please wait while we are cancelling your ${isPickup ? 'pickup' : 'delivery'}...",
              );
            },
          );
        }

        if (state is DestinationDetailsFail) {
          toast.show(toast: WarningToast(msg: state.error.message));
        }

        if (state is LaunchMapFailed) {
          toast.show(toast: WarningToast(msg: "Can't launch map"));
        }

        if (state is DestinationDetailsSuccess ||
            state is DestinationDetailsCancelSuccess) {
          Timer(Duration(seconds: 2), () {
            if (state is DestinationDetailsCancelSuccess) {
              BlocProvider.of<HomeCubit>(context).goto(
                "failed_delivery",
                params: state.acceptDelivery,
              );
            }

            Navigator.pop(context);
          });
        }

        if (state is DestinationDeliveredSuccess) {
          BlocProvider.of<HomeCubit>(context).goto(
            "proof_of_delivery",
            params: destination,
          );
        }

        if (state is DestinationPickupSuccess) {
          BlocProvider.of<HomeCubit>(context).goto(
            "pickup_delivery",
            params: destination,
          );
        }
      },
      builder: (context, state) {
        bool notStarted = !this.started && state is DestinationDetailsInitial;
        bool hasArrived = this.arrived || state is DestinationArrivedSuccess;
        bool isPickup = destination.type.toLowerCase().contains("pick");

        if (!notStarted) {
          BlocProvider.of<HomeCubit>(context).goto(
            "started_delivery",
            params: (isPickup ? "Pickup" : "Delivery") + " Started",
          );
        }

        if (hasArrived) {
          BlocProvider.of<HomeCubit>(context).goto(
            "arrived_destination",
            params: (isPickup ? "Pickup" : "Delivery") + " Destination",
          );
        }

        return Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children:
                      destination.parcels.map((e) => ParcelCard(e)).toList(),
                )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    notStarted
                        ? PrimaryButton(
                            text: "START",
                            onPressed: () {
                              BlocProvider.of<DeliveriesCubit>(context)
                                  .startDelivery();
                              BlocProvider.of<DeliveriesCubit>(context)
                                  .updateDestinationStatus(
                                destinations: [destination.id],
                                status: "Started",
                              );
                              BlocProvider.of<DestinationDetailsCubit>(context)
                                  .startDelivery(destination);
                            },
                          )
                        : hasArrived
                            ? Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: PrimaryButton(
                                      text: isPickup ? "PICKUP" : "DELIVER",
                                      onPressed: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            BlocProvider.of<DeliveriesCubit>(
                                                    context)
                                                .updateDestinationStatus(
                                              destinations: [destination.id],
                                              status: "Waiting",
                                            );
                                            return LoadingModal(
                                              title: isPickup
                                                  ? "Pickup"
                                                  : "Deliver",
                                              subtitle: isPickup
                                                  ? "Loading items to be pickup"
                                                  : "Loading items to be delivered",
                                            );
                                          },
                                        );
                                        Timer(
                                          Duration(seconds: 2),
                                          () {
                                            final route = isPickup
                                                ? "pickup_delivery"
                                                : "proof_of_delivery";
                                            BlocProvider.of<HomeCubit>(context)
                                                .goto(
                                              route,
                                              params: destination,
                                            );
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Flexible(
                                    flex: 1,
                                    child: GrayButton(
                                      text: "CANCEL",
                                      onPressed: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return YesNoModal(
                                              buttonType: "danger",
                                              title:
                                                  "Are you sure you want to cancel?",
                                              subtitle:
                                                  "Cancelling a delivery will have an affect to your account",
                                              onAnswer: (value) {
                                                if (value) {
                                                  BlocProvider.of<
                                                              DeliveriesCubit>(
                                                          context)
                                                      .updateDestinationStatus(
                                                    destinations: [
                                                      destination.id
                                                    ],
                                                    status: "Failed",
                                                  );

                                                  final bloc = BlocProvider.of<
                                                      DestinationDetailsCubit>(
                                                    context,
                                                  );
                                                  destination.type
                                                          .toLowerCase()
                                                          .contains("pickup")
                                                      ? bloc.cancelPickup(
                                                          destination,
                                                        )
                                                      : bloc.cancelDelivery(
                                                          destination,
                                                        );
                                                }
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: PrimaryButton(
                                  text: "ARRIVED",
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        BlocProvider.of<DeliveriesCubit>(
                                                context)
                                            .updateDestinationStatus(
                                          destinations: [destination.id],
                                          status: "Arrived",
                                        );
                                        return LoadingModal(
                                          title: "Arriving",
                                          subtitle:
                                              "You are now arriving at the destination",
                                        );
                                      },
                                    );
                                    Timer(Duration(seconds: 2), () {
                                      BlocProvider.of<DestinationDetailsCubit>(
                                        context,
                                      ).arrived(destination);
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
