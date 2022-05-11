import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';
import 'package:promdifarm_app/view/widgets/destinations/proof_consignee/proof_consignee_card.dart';
import 'package:promdifarm_app/view/widgets/destinations/proof_consignee/proof_consignee_parcel_card.dart';
import 'package:promdifarm_app/view/widgets/modal.widget.dart';

class ProofConsigneeList extends StatelessWidget {
  final Destination destination;
  const ProofConsigneeList(this.destination);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocConsumer<DeliveryProofCubit, DeliveryProofState>(
        listener: (context, state) {
          if (state is CompletingDelivery) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext ctx) {
                return LoadingModal(
                  title: "Completing Delivery",
                  subtitle:
                      "Please wait while we are completing current delivery...",
                );
              },
            );
          }

          if (state is CompletingDeliverySuccess ||
              state is DeliveryProofFail) {
            Timer(Duration(seconds: 2), () {
              Navigator.pop(context);

              if (state is CompletingDeliverySuccess) {
                BlocProvider.of<HomeCubit>(context).goto(
                  "done_delivery",
                  params: state.acceptDelivery,
                );
              }
            });
          }
        },
        builder: (context, state) {
          bool hasImage = state is HasImage;
          final buttonName = "FINISH DELIVERY";

          return Container(
            padding: EdgeInsets.all(10),
            child: hasImage
                ? PrimaryButton(
                    text: buttonName,
                    onPressed: () {
                      BlocProvider.of<DeliveriesCubit>(context)
                          .updateDestinationStatus(
                        destinations: [destination.id],
                        status: "Completed",
                      );
                      BlocProvider.of<DeliveryProofCubit>(context)
                          .completeDelivery(destination, state.image);
                    },
                  )
                : GrayButton(
                    text: buttonName,
                    onPressed: () {},
                  ),
          );
        },
      ),
      body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.fromLTRB(18, 14, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...destination.parcels.map((e) => ConsigneeParcelCard(e)),
                  Container(
                    child: Column(
                      children: [
                        BlocBuilder<DeliveryProofCubit, DeliveryProofState>(
                          builder: (context, state) {
                            if (state is HasImage) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.maxFinite,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          Image.file(
                                            state.image,
                                            height: 80,
                                            width: 80,
                                          ),
                                          Expanded(
                                            child: Text(
                                              state.image.path.split('/').last,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: InkWell(
                                              child: Icon(
                                                Icons.close_sharp,
                                                size: 40,
                                                color: RED,
                                              ),
                                              onTap: () {
                                                BlocProvider.of<
                                                            DeliveryProofCubit>(
                                                        context)
                                                    .deleteImage();
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<DeliveryProofCubit>(context)
                                    .openCamera();
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(Icons.camera_alt_outlined),
                                      ),
                                      Text("Attach a Photo"),
                                      Spacer(),
                                      Text("No image selected"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget inputControl() {
    return Container(
      child: Column(children: []),
    );
  }
}
