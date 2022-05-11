import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:flutter/material.dart';
import 'order_card.widget.dart';

class OrderList extends StatelessWidget {
  final List<Delivery> deliveries;
  OrderList({required this.deliveries});

  @override
  Widget build(BuildContext context) {
    final hasAccepted = deliveries
        .where((delivery) => delivery.status.toLowerCase() == 'accepted')
        .toList();

    if (hasAccepted.isNotEmpty) {
      BlocProvider.of<HomeCubit>(context).goto(
        "tab_list",
        params: hasAccepted[0].id.toString(),
      );

      return Container(child: Center(child: CircularProgressIndicator()));
    }

    return Expanded(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: this
                  .deliveries
                  .map((delivery) => OrderListItem(delivery))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
