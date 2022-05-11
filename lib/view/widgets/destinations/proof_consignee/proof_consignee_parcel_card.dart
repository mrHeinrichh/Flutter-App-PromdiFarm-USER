import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/data/models/parcel/parcel.model.dart';
import 'package:promdifarm_app/view/bloc/index.dart';

class ConsigneeParcelCard extends StatelessWidget {
  final Parcel parcel;
  const ConsigneeParcelCard(this.parcel);

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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Ref. Num : '),
                  Text(
                    '${parcel.refNum}',
                    style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Item Code: ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: NEUTRAL_PRIMARY_DARK),
                  ),
                  Text(
                    '${parcel.refNum}',
                    style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Description: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: NEUTRAL_PRIMARY_DARK,
                    ),
                  ),
                  Text(
                    '${parcel.refNum} ${parcel.refNum}',
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
            ],
          ),
        ),
      ),
    );
  }
}
