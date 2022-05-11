import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/view/widgets/input_control.dart';

class PasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: DARK,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(ROUTE.PROFILE);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      bottomNavigationBar: navBottom(),
      body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.fromLTRB(18, 20, 16, 0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                    alignment: Alignment(0.0, -0.79),
                    child: Column(
                      children: [
                        InputControl(
                          title: "Old Password",
                          height: 33,
                          width: 310,
                        ),
                        InputControl(
                          title: "New Password",
                          height: 33,
                          width: 310,
                        ),
                        InputControl(
                          title: "Re-type Password",
                          height: 33,
                          width: 310,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget navBottom() {
    return Container(
      child: Stack(
        alignment: FractionalOffset(.5, .40),
        children: [
          Container(
            height: 90.0,
            color: TEXT_LIGHT,
          ),
          ButtonTheme(
            minWidth: 340.0,
            height: 50,
            padding: EdgeInsets.only(bottom: .70),
            child: RaisedButton(
              onPressed: () {},
              color: DARK,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Update Password",
                style: TextStyle(color: TEXT_LIGHT, fontFamily: 'Roboto'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputControl() {
    return Container(
      child: Column(children: []),
    );
  }
}
