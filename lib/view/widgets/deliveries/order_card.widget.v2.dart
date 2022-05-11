import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';

class OrderListItemv2 extends StatelessWidget {
  final int noItems;
  final int fee;
  final String payment;
  final String refNum;
  final String status;

  const OrderListItemv2({
    required this.noItems,
    required this.fee,
    required this.payment,
    required this.refNum,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    orderText(
                      title: "Delivery No. ",
                      value: refNum.toString(),
                    ),
                    Spacer(),
                    Text(
                      status,
                      style: TextStyle(
                          fontSize: 11, color: NEUTRAL_PRIMARY_NORMAL),
                    )
                  ],
                ),
                orderText(
                  title: "No. of Items: ",
                  value: noItems.toString(),
                ),
                orderText(title: "Delivery Fee: ", value: '₱ ${fee + 0.00}'),
                orderText(title: "Type of Payment: ", value: payment),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderText({required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.only(left: 15, bottom: 3),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: NEUTRAL_PRIMARY_NORMAL,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            value,
            style: TextStyle(
              color: NEUTRAL_PRIMARY_NORMAL,
              fontSize: 12,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
