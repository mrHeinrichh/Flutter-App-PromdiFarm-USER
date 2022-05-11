import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';

class InviteFriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Invite Friends"),
        backgroundColor: DARK,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(ROUTE.HOME);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            card(),
            buttons(),
          ],
        ),
      ),
    );
  }

  Widget card() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 15),
      width: 360,
      child: Card(
        child: Container(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  paragraph(),
                  Image.network(
                    IMAGE.FEMALE,
                    width: 150,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget line({content = ""}) {
    return Center(
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: NEUTRAL_PRIMARY_DARK,
        ),
      ),
    );
  }

  Widget paragraph() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          line(content: "Invite your friends and"),
          line(content: "become a Yahu"),
          line(content: "to help our Local Farmers"),
        ],
      ),
    );
  }

  Widget buttons() {
    return Container(
      child: Column(
        children: [
          PrimaryButton(
            text: "Share your link ",

            // margin: EdgeInsets.only(bottom: 10),
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          WhiteButton(
            text: "Scan QR Code ",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
