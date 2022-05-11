import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/const/strings.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/widgets/checkbox.widget.dart';
import 'package:promdifarm_app/view/widgets/text.widget.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Settings"),
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
          return Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              children: [
                Card(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Header3(
                            "Language",
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 10,
                            ),
                            child: Text(
                              "English/Filipino",
                              style: TextStyle(
                                color: NEUTRAL_SECONDARY_BASE,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Header3(
                            "Notifications",
                          ),
                        ),
                        CheckBoxText(
                          title: "Receive push notification",
                          value: true,
                          onChanged: (value) {},
                        ),
                        CheckBoxText(
                          title: "Receive offers by email",
                          value: true,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text("Version 1.0.0.0 (221325676)"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
