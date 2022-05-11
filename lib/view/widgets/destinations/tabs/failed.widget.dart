import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/home/home.cubit.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/empty_tab.widget.dart';
import 'package:promdifarm_app/view/widgets/destinations/tabs/tab_content.widget.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/view/widgets/destinations/destination_card.widget.dart';

class Failed extends StatelessWidget {
  final List<Destination> failed;
  Failed(this.failed);

  @override
  Widget build(BuildContext context) {
    List<Widget> routes = failed.map((destination) {
      return FailedDestination(
        destination: destination,
        onTap: () {
          BlocProvider.of<HomeCubit>(context).goto(
            "failed_destination",
            params: destination,
          );
        },
      );
    }).toList();

    return Scaffold(
      body: routes.length == 0
          ? EmptyTab(
              imageUrl: IMAGE.EMPTY_FAILED_DELIVERY,
              title: "Keep up the good work!",
              titleSize: 25,
              subtitle: "No canceled or failed deliveries today!",
            )
          : TabContent(routes),
    );
  }
}
