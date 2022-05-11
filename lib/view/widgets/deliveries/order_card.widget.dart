import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/view/bloc/home/home.cubit.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';

class OrderListItem extends StatelessWidget {
  final Delivery delivery;

  const OrderListItem(this.delivery);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              children: [
                Text(
                  "Delivery No.",
                  style: TextStyle(
                    color: NEUTRAL_PRIMARY_NORMAL,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  this.delivery.code,
                  style: TextStyle(
                    color: NEUTRAL_PRIMARY_DARK,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                orderText(
                  title: "No. of Items: ",
                  value: delivery.parcels.length.toString(),
                ),
                orderText(title: "Delivery Fee: ", value: "₱ 0.0"),
                orderText(
                    title: "Type of Payment: ", value: "Cash on Delivery"),
              ],
            ),
          ),
          PrimaryButton(
            text: "ACCEPT",
            onPressed: () {
              BlocProvider.of<HomeCubit>(context).goto(
                "tab_list",
                params: this.delivery.id.toString(),
              );
            },
          )
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
