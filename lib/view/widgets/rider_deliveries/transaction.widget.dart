import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/data/models/delivery.model.dart';
import '../../../core/const/index.dart';

class Transaction extends StatelessWidget {
  final String date;
  final double amount;
  final String num;
  final Delivery delivery;

  const Transaction({
    required this.date,
    this.amount = 0.00,
    required this.num,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          context.goNamed(ROUTE.TRANSACTION);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: NEUTRAL_PRIMARY_BASE,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: $date',
                      style: TextStyle(
                        color: NEUTRAL_PRIMARY_NORMAL,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '+P${amount.toString()}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: NEUTRAL_PRIMARY_NORMAL,
                          ),
                        ),
                        Text(
                          this.delivery.code,
                          style: TextStyle(
                            color: NEUTRAL_PRIMARY_DARK,
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Ref Num: $num',
                      style: TextStyle(
                        color: NEUTRAL_PRIMARY_NORMAL,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> list;
  const TransactionList({required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: list.toList(),
        ),
      ),
    );
  }
}

class TransactionTitle extends StatelessWidget {
  final int quantity;
  TransactionTitle({required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Text(
        "All Transactions (${quantity.toString()})",
        style: TextStyle(
          fontSize: 15,
          color: NEUTRAL_PRIMARY_NORMAL,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
