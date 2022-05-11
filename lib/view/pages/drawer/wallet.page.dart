import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/view/widgets/shared.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: Shared.appBar(title: "My Wallet"),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(),
          Text("Available Balance"),
          transactions(),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: NEUTRAL_PRIMARY_ACCENT,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Available Balance"),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "₱",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "1300",
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  ".00",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Shared.button(
            height: 35,
            width: 160,
            title: "Top Up",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget transactions() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          trasanction(),
          trasanction(),
          trasanction(),
        ],
      ),
    );
  }

  Widget trasanction() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Friday"),
                Text("Booking #12343"),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("+130.00"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
