import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';

class TabContent extends StatelessWidget {
  final List<Widget> routes;
  TabContent(this.routes);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        color: NEUTRAL_PRIMARY_ACCENT,
        child: Column(children: routes),
      ),
    );
  }
}
