import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/data/models/parcel/parcel.model.dart';

class FailedCard extends StatelessWidget {
  final Parcel parcel;
  const FailedCard(this.parcel);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: SECONDARY,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Item Information',
                      style: TextStyle(
                        color: TEXT_LIGHT,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '${parcel.refNum}',
                    style: TextStyle(
                      color: TEXT_LIGHT,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: NEUTRAL_PRIMARY_NORMAL,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Item Code: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: PRIMARY),
                      ),
                      Text(
                        '${parcel.refNum}',
                        style: TextStyle(color: TEXT_LIGHT),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Description : ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: PRIMARY),
                      ),
                      Text(
                        '${parcel.refNum}',
                        style: TextStyle(color: TEXT_LIGHT),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Weight: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: PRIMARY),
                      ),
                      Text(
                        '${parcel.weight}',
                        style: TextStyle(color: TEXT_LIGHT),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: DARK,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Shipper :",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: NEUTRAL_PRIMARY_DARK,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: NEUTRAL_PRIMARY_NORMAL,
                              size: 15,
                            ),
                            Text(
                              ' ${parcel.tenant.name} ',
                              style: TextStyle(
                                color: SECONDARY,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: NEUTRAL_PRIMARY_NORMAL,
                              size: 15,
                            ),
                            Text(
                              ' ${parcel.tenant.phoneNumber}',
                              style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: NEUTRAL_PRIMARY_NORMAL,
                              size: 15,
                            ),
                            Text(
                              ' ${parcel.pickupAddress.address.fullAddress}',
                              style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Delivered to :",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: NEUTRAL_PRIMARY_DARK),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: NEUTRAL_PRIMARY_NORMAL,
                              size: 15,
                            ),
                            Text(
                              ' ${parcel.consignee.firstName} ${parcel.consignee.lastName}',
                              style: TextStyle(
                                color: SECONDARY,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: NEUTRAL_PRIMARY_NORMAL,
                              size: 15,
                            ),
                            Text(
                              ' ${parcel.consignee.phoneNumber}',
                              style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: NEUTRAL_PRIMARY_NORMAL,
                              size: 15,
                            ),
                            Text(
                              ' ${parcel.pickupAddress.address.fullAddress}',
                              style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
