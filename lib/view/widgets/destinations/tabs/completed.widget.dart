import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/home/home.cubit.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/empty_tab.widget.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/tab_content.widget.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/view/widgets/destinations/destination_card.widget.dart';

class Completed extends StatelessWidget {
  final List<Destination> completed;
  Completed(this.completed);

  @override
  Widget build(BuildContext context) {
    List<Widget> routes = completed.map((destination) {
      return CompletedDestination(
        destination: destination,
        onTap: () {
          BlocProvider.of<HomeCubit>(context).goto(
            "completed_delivery",
            params: destination,
          );
        },
      );
    }).toList();

    return Scaffold(
      body: routes.length == 0
          ? EmptyTab(
              imageUrl: IMAGE.EMPTY_COMPLETED_DELIVERY,
              title: "Oops!!",
              titleSize: 25,
              subtitle: "Looks like you haven't completed any deliveries yet!",
            )
          : TabContent(routes),
    );
  }
}
