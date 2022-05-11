import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/view/widgets/modal.widget.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';
import 'package:promdifarm_app/view/widgets/destinations/failed/failed_card.dart';

class FailedList extends StatelessWidget {
  final Destination destination;
  const FailedList(this.destination);

  @override
  Widget build(BuildContext context) {
    Widget button = Container();

    if (!destination.type.toLowerCase().contains("pick")) {
      button = Align(
        alignment: Alignment.bottomCenter,
        child: PrimaryButton(
          text: "RETRY DELIVERY",
          onPressed: () {
            BlocProvider.of<DeliveriesCubit>(context)
                .retryDelivery(destination);
          },
        ),
      );
    }

    return Scaffold(
      body: BlocConsumer<DeliveriesCubit, DeliveriesState>(
        listener: (context, state) {
          if (state is RetryDelivery) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext ctx) {
                return LoadingModal(
                  title: "Retry Delivery",
                  subtitle:
                      "Please wait while we are loading delivery details...",
                );
              },
            );
          }

          if (state is RetryDeliverySuccess) {
            Timer(Duration(seconds: 2), () {
              BlocProvider.of<HomeCubit>(context).goto(
                "destination",
                params: {"destination": destination},
              );

              Navigator.pop(context);
            });
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...destination.parcels.map((e) => FailedCard(e))
                        ],
                      ),
                    ),
                  ),
                ),
                button
              ],
            ),
          );
        },
      ),
    );
  }
}
