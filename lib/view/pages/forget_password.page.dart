import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/view/widgets/shared.dart';
import 'package:go_router/go_router.dart';

const double FIELD_WIDTH = 306;

class ForgetPasswordPage extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              header(),
              SizedBox(
                height: 30,
              ),
              form(),
              SizedBox(
                height: 30,
              ),
              Shared.button(
                height: 56,
                width: 186,
                title: "Continue",
                onPressed: () {
                  context.goNamed("home");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shared.textField(
              controller: _controller,
              width: FIELD_WIDTH,
              label: "Email address",
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      child: Column(
        children: [
          Text(
            "Forget Password?",
            style: TextStyle(
              fontFamily: "Roboto",
              color: TEXT_DARK,
              fontSize: 30 * 0.9,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Please enter your email to reset your password",
            style: TextStyle(
              fontFamily: "Roboto",
              color: TEXT_PRIMARY,
              fontSize: 16 * 0.9,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
