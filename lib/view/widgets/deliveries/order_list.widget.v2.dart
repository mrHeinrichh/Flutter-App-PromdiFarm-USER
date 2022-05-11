import 'package:flutter/material.dart';
import 'package:promdifarm_app/view/widgets/deliveries/order_card.widget.v2.dart';

class OrderListv2 extends StatelessWidget {
  final List<dynamic> deliveries;
  OrderListv2({required this.deliveries});

  @override
  Widget build(BuildContext context) {
    // final hasAccepted = deliveries
    //     .where((delivery) => delivery.status.toLowerCase() == 'accepted')
    //     .toList();

    // if (hasAccepted.isNotEmpty) {
    //   BlocProvider.of<HomeCubit>(context).goto(
    //     "tab_list",
    //     params: hasAccepted[0].id.toString(),
    //   );

    //   return Container(child: Center(child: CircularProgressIndicator()));
    // }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: this
            .deliveries
            .map((delivery) => OrderListItemv2(
                  refNum: delivery["code"],
                  status: delivery["status"],
                  noItems: delivery["parcels"].length ?? 0,
                  fee: 1,
                  payment: "1",
                ))
            .toList(),
      ),
    );
  }
}
