import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';

class BirthDate extends StatelessWidget {
  final double width;
  final String tagName;
  final String label;
  final String datePick;
  final bool obscureText;
  final TextEditingController controller;
  final bloc = sl<DateCubit>();

  BirthDate({
    required this.width,
    this.tagName = "",
    this.label = "",
    this.datePick = "",
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: BlocBuilder<DateCubit, DateState>(builder: (context, state) {
          if (state is GetDate) {
            controller.text = DateFormat('yyyy-MM-dd').format(state.dateTime);
          }
          return SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tagName,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: width,
                  height: 25,
                  child: TextField(
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          BlocProvider.of<DateCubit>(context)
                              .openDateTime(context);
                        },
                        child: Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: NEUTRAL_PRIMARY_ACCENT,
                      labelText: label,
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      color: TEXT_PRIMARY,
                    ),
                    maxLines: 1,
                    controller: controller,
                    onTap: () {
                      // Text("${selectedDate(context)}");
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
