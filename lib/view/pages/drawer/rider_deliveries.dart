import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/view/widgets/deliveries/order_list.widget.v2.dart';
import 'package:promdifarm_app/view/widgets/rider_deliveries/transaction.widget.dart';

class RiderDeliveries extends StatelessWidget {
  const RiderDeliveries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Deliveries"),
        backgroundColor: DARK,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(ROUTE.HOME_BACK);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
        builder: (context, state) {
          if (state is DeliveriesInitial) {
            BlocProvider.of<DeliveriesCubit>(context).getRiderDeliveries();
          }

          if (state is RiderDeliveriesSuccess) {
            final DateFormat formatter = DateFormat('yyyy-MM-dd');

            return Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TransactionTitle(
                      quantity: state.riderDeliveries.length,
                    ),
                    OrderListv2(deliveries: state.riderDeliveries)
                  ],
                ),
              ),
            );
          }
          return Container(
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransactionTitle(
                    quantity: 0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
