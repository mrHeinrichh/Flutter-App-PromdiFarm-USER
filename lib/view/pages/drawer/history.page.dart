import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Completed"),
        backgroundColor: DARK,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(ROUTE.RIDER_DELIVERIES);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.fromLTRB(18, 20, 16, 0),
            child: Column(
              children: [
                Container(
                  height: 110,
                  width: 400,
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Delivered on",
                          style: TextStyle(
                              fontSize: 14, color: NEUTRAL_PRIMARY_DARK),
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        deliveredDate(date: "Friday, 1 April 2022"),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 480,
                  child: Card(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 19.0, vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3,
                          ),
                          cardNav(),
                          SizedBox(
                            height: 3,
                          ),
                          Divider(color: NEUTRAL_PRIMARY_BASE),
                          SizedBox(
                            height: 15,
                          ),
                          contents(),
                        ],
                      ),
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

  Widget deliveredDate({String date = ""}) {
    return Container(
      child: Text(
        date,
        style: TextStyle(
            fontSize: 25,
            color: NEUTRAL_PRIMARY_DARK,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget cardNav() {
    return Row(
      children: [
        Text(
          "Booking No.",
          style: TextStyle(
              fontSize: 13,
              color: NEUTRAL_PRIMARY_DARK,
              fontWeight: FontWeight.w600),
        ),
        bookingNum(bookNam: "123456 (#12)"),
        SizedBox(
          width: 5,
        ),
        Text(
          "COPY",
          style: TextStyle(
              fontSize: 12, color: PRIMARY, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget contents() {
    return Container(
      child: Column(
        children: [
          first(
            status: "Product has been delivered",
            date: "1 April",
            time: "13:03",
            name: "Armando Perez",
            riderName: "Heinrich",
            phoneNumber: "+63 9569749935",
          ),
          midLine(
              indicatorXY: 0.2,
              status: "Product is out for delivery",
              date: "1 April",
              time: "13:03"),
          midLine(
              indicatorXY: 0.2,
              status: "Product has arrived at sorting station",
              date: "1 April",
              time: "13:03"),
          midLine(
              indicatorXY: 0.2,
              status: "Product has departed from station",
              date: "1 April",
              time: "13:03"),
          midLine(
              indicatorXY: 0.2,
              status: "Product has been received at station",
              date: "1 April",
              time: "13:03"),
          midLine(
              indicatorXY: 0.2,
              status: "Product has departed from nueva ecija",
              date: "1 April",
              time: "13:03"),
          last(
              status: "Farmer is preparing your product",
              date: "28 Mar",
              time: "10:22"),
        ],
      ),
    );
  }

  Widget midLine({
    double indicatorXY = 0.1,
    String status = "",
    String date = "",
    String time = "",
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      child: TimelineTile(
        endChild: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 11,
                  ),
                  Text(
                    status,
                    style: TextStyle(fontSize: 11, color: NEUTRAL_PRIMARY_BASE),
                  ),
                ],
              ),
            ],
          ),
        ),
        startChild: Column(
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 11, color: NEUTRAL_PRIMARY_BASE),
            ),
            Text(
              time,
              style: TextStyle(fontSize: 11, color: NEUTRAL_PRIMARY_BASE),
            )
          ],
        ),
        alignment: TimelineAlign.manual,
        lineXY: 0.3,
        indicatorStyle: IndicatorStyle(
          width: 20,
          color: NEUTRAL_PRIMARY_BASE,
          indicatorXY: indicatorXY,
        ),
        beforeLineStyle: LineStyle(
          color: NEUTRAL_PRIMARY_BASE,
          thickness: 2,
        ),
        afterLineStyle: LineStyle(
          color: NEUTRAL_PRIMARY_BASE,
          thickness: 2,
        ),
      ),
    );
  }

  Widget last({
    String status = "",
    String date = "",
    String time = "",
  }) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      isLast: true,
      beforeLineStyle: const LineStyle(
        color: NEUTRAL_PRIMARY_BASE,
        thickness: 2,
      ),
      indicatorStyle: const IndicatorStyle(
        width: 20,
        color: NEUTRAL_PRIMARY_BASE,
        indicatorXY: 0.1,
      ),
      startChild: Column(
        children: [
          Text(
            date,
            style: TextStyle(fontSize: 11, color: NEUTRAL_PRIMARY_BASE),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 11, color: NEUTRAL_PRIMARY_BASE),
          ),
        ],
      ),
      endChild: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 11,
                ),
                Text(
                  status,
                  style: TextStyle(fontSize: 11, color: NEUTRAL_PRIMARY_BASE),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingNum({String bookNam = ""}) {
    return Container(
      child: Text(
        bookNam,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget first({
    String status = "",
    String date = "",
    String time = "",
    String name = "",
    String riderName = "",
    String phoneNumber = "",
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 90),
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.3,
        indicatorStyle: const IndicatorStyle(
          width: 20,
          color: DARK,
          indicatorXY: 0.2,
        ),
        beforeLineStyle: const LineStyle(
          color: NEUTRAL_PRIMARY_BASE,
          thickness: 2,
        ),
        isFirst: true,
        startChild: Column(
          children: [
            Text(
              date,
              style: TextStyle(
                fontSize: 11,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
        endChild: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Recipients:",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              name,
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "View Proof of Delivery",
                              style: TextStyle(fontSize: 11, color: DARK),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Rider: ",
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              riderName,
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              " | ",
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              phoneNumber,
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
