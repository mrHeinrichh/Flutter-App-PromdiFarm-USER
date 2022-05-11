import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/view/widgets/destinations/completed/completed_card.dart';

class CompletedList extends StatelessWidget {
  final Destination destination;
  const CompletedList(this.destination);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.fromLTRB(18, 14, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [...destination.parcels.map((e) => CompletedCard(e))],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget inputControl() {
    return Container(
      child: Column(children: []),
    );
  }
}
