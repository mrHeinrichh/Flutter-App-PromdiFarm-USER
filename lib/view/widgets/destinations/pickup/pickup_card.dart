import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/data/models/parcel/parcel.model.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/widgets/modal.widget.dart';

class PickUpCard extends StatelessWidget {
  final Parcel parcel;
  const PickUpCard(this.parcel);

  @override
  Widget build(BuildContext context) {
    final pickupCardBloc = sl<PickUpCardCubit>();
    return BlocProvider.value(
      value: pickupCardBloc,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shopping_bag_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Parcel item",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext ctx) {
                          return YesNoModal(
                            buttonType: "danger",
                            title: "Are you sure you want to cancel?",
                            subtitle:
                                "Cancelling a pickup will remove it from your deliveries.",
                            onAnswer: (value) {
                              if (value) {
                                BlocProvider.of<PickUpListCubit>(
                                  context,
                                ).cancelItem(this.parcel);
                              }
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        color: ACCENT,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Ref. Num :'),
                  Text(
                    '${parcel.refNum}',
                    style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'No. of Items: ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: NEUTRAL_PRIMARY_DARK),
                  ),
                  Text(
                    '${parcel.items.length}',
                    style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Weight: ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: NEUTRAL_PRIMARY_DARK),
                  ),
                  Text(
                    '${parcel.weight}',
                    style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 2),
              BlocBuilder<PickUpCardCubit, PickUpCardState>(
                builder: (context, state) {
                  if (state is PickUpCardHasImage) {
                    BlocProvider.of<PickUpListCubit>(
                      context,
                    ).addImage(this.parcel.id, state.image);
                  }

                  if (state is PickUpCardDelete) {
                    BlocProvider.of<PickUpListCubit>(
                      context,
                    ).removeImage(this.parcel.id);
                  }

                  return parcel.hasImage
                      ? Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Image.file(
                                  parcel.image!,
                                  height: 50,
                                  width: 50,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      parcel.image!.path.split('/').last,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.close_sharp,
                                    size: 35,
                                  ),
                                  onTap: () {
                                    pickupCardBloc.deleteImage();
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            pickupCardBloc.openCamera();
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.camera_alt_outlined),
                              ),
                              Text("Attach a Photo "),
                              Spacer(),
                              Text(
                                "No image selected",
                                style: TextStyle(
                                  color: RED,
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
              BlocBuilder<PickUpCardCubit, PickUpCardState>(
                builder: (context, state) {
                  if (parcel.image != null) {
                    return PrimaryButton(
                      text: "ACCEPT ITEM",
                      onPressed: () {
                        BlocProvider.of<PickUpListCubit>(
                          context,
                        ).acceptItem(this.parcel);
                      },
                    );
                  }

                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
