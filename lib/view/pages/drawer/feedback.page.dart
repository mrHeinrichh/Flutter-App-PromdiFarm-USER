import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';
import 'package:promdifarm_app/view/widgets/input_control.dart';

class PageFeedback extends StatelessWidget {
  const PageFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: PRIMARY,
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
            margin: EdgeInsets.fromLTRB(10, 20, 11, 0),
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: Card(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Let's talk!",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InputControl(title: "Full name"),
                          InputControl(
                            title: "Email address",
                          ),
                          InputControl(title: "Mobile Number"),
                          InputControl(
                            title: "What would you like to discuss?",
                            height: 100,
                            width: 320,
                            maxLines: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    child: buttons(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buttons() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          PrimaryButton(
            text: "SUBMIT ",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
