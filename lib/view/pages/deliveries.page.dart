import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/widgets/deliveries/index.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/empty_tab.widget.dart';
import 'package:promdifarm_app/view/widgets/modal.widget.dart';
import 'package:promdifarm_app/view/widgets/toasts/toast.widget.dart';

class DeliveriesPage extends StatelessWidget {
  final ToastInstance toast = ToastInstance();

  @override
  Widget build(BuildContext context) {
    toast.init(context);
    return BlocConsumer<DeliveriesCubit, DeliveriesState>(
      listener: (context, state) {
        if (state is DeliveriesFail &&
            state.error.message.toLowerCase().contains("login")) {
          toast.show(
            toast: ErrorToast(msg: state.error.message),
          );

          context.goNamed(ROUTE.LOGIN);
        }

        if (state is DeliveriesFail) {
          toast.show(
            toast: ErrorToast(msg: state.error.message),
          );
        }

        if (state is EndCurrentSessionSuccess) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext ctx) {
              return LoadingModal(
                title: "Ending Session",
                subtitle: "Please wait while we updating your session...",
              );
            },
          );
          BlocProvider.of<DeliveriesCubit>(context).getAvailableDeliveries();
        }

        if (state is GetDeliveriesSuccess) {
          toast.show(
            toast: SuccessToast(
              msg: "Get deliveries successfully",
            ),
          );

          Timer(Duration(seconds: 2), () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        }
      },
      buildWhen: (context, state) {
        return !(state is EndCurrentSession ||
            state is EndCurrentSessionSuccess);
      },
      builder: (context, state) {
        if (state is DeliveriesInitial &&
            !(BlocProvider.of<HomeCubit>(context).state is EndDelivery)) {
          BlocProvider.of<DeliveriesCubit>(context).getAvailableDeliveries();
        }

        if (state is DeliveriesInitial &&
            BlocProvider.of<HomeCubit>(context).state is EndDelivery) {
          BlocProvider.of<DeliveriesCubit>(context).endDelivery();
        }

        if (state is DeliveriesInitial ||
            state is DeliveriesLoading ||
            state is EndCurrentSession) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        }

        return setOrderList(state.deliveries);
      },
    );
  }

  Widget setOrderList(List<Delivery> deliveries) {
    return deliveries.length == 0
        ? Expanded(
            child: EmptyTab(
              imageUrl: IMAGE.EMPTY_PENDING_DELIVERY,
              title: "We are sorry!!!",
              titleSize: 25,
              subtitle:
                  "There are no new orders available in your area.\nTry refreshing the list after several minutes.",
            ),
          )
        : OrderList(deliveries: deliveries);
  }
}
