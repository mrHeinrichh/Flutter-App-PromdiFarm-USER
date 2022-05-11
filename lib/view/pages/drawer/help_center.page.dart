import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:go_router/go_router.dart';

class HelpCentre extends StatelessWidget {
  const HelpCentre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Help Centre"),
        backgroundColor: DARK,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(ROUTE.HOME);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
        builder: (context, state) {
          return Container(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: supportItemList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> supportItemList() {
    return [
      title(),
      supportItem(problem: "My Orders"),
      divider(),
      supportItem(problem: "Support request"),
      divider(),
      supportItem(problem: "My Account"),
      divider(),
      supportItem(problem: "Orders and Payment"),
      divider(),
      supportItem(problem: "Get help with my pay"),
      divider(),
      supportItem(problem: "Safety Concerns"),
      divider(),
      supportItem(problem: "How to become a YahuRider"),
      divider(),
      supportItem(problem: "How to become a YahuFarmer"),
      divider(),
      supportItem(problem: "Selling and Billing"),
      divider(),
      supportItem(problem: "Return & Refund"),
      divider(),
      supportItem(problem: "Shipping & Delivery"),
      divider(),
      supportItem(problem: "My Enquiries"),
      divider(),
      supportItem(problem: "FAQ"),
    ];
  }

  Widget divider({indent = 16.0}) {
    return Divider(
      color: NEUTRAL_PRIMARY_BASE,
      endIndent: indent,
      indent: indent,
    );
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        "How can we help?",
        style: TextStyle(
          fontSize: 16,
          color: NEUTRAL_PRIMARY_DARK,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget supportItem({String problem = ""}) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  problem,
                  style: TextStyle(
                    fontSize: 13,
                    color: NEUTRAL_PRIMARY_DARK,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: NEUTRAL_PRIMARY_BASE,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
