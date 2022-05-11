import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/core/services/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/widgets/shared.dart';
import 'package:flutter/gestures.dart';
import 'package:promdifarm_app/view/widgets/toasts/toast.widget.dart';

class LoginPage extends StatelessWidget {
  final _cred = TextEditingController();
  final _pass = TextEditingController();
  final ToastInstance toast = ToastInstance();
  final LoginService loginService;

  LoginPage(this.loginService);

  @override
  Widget build(BuildContext context) {
    toast.init(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<UserCubit, UserState>(
          buildWhen: (context, state) {
            return !(state is AuthUserSuccess);
          },
          listener: (context, state) {
            if (state is AuthUserSuccess) {
              loginService.login();
            }

            if (state is RefreshTokenNotFound &&
                state.error.message.toLowerCase().contains("session")) {
              toast.show(
                toast: WhiteToast(
                  msg: "Please login again!",
                  status: state.error.message,
                ),
              );
            }

            if (state is AuthUserFail) {
              toast.show(
                toast: ErrorToast(msg: state.error.message),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthUserLoading)
              return Scaffold(body: Center(child: CircularProgressIndicator()));

            return body(context);
          },
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
      child: Image.network(
        IMAGE.ONLINE,
        height: 176 * 0.8,
        width: 258.12 * 0.8,
      ),
    );
  }

  Widget form() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Shared.textField(
            width: FIELD_WIDTH,
            label: "Email or phone number",
            controller: _cred,
          ),
          SizedBox(
            height: 20,
          ),
          Shared.textField(
            width: FIELD_WIDTH,
            obscureText: true,
            label: "Password",
            controller: _pass,
          ),
        ],
      ),
    );
  }

  Widget signUp(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                fontFamily: "Roboto",
                color: TEXT_PRIMARY,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: 'Sign up here',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: DARK,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.goNamed(ROUTE.SIGN_UP);
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget forgot() {
    return Center(
      child: Text(
        'Or log in with',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Roboto",
          color: NEUTRAL_PRIMARY_BASE,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget socials() {
    return Container(
      child: Image(
        image: NetworkImage(IMAGE.ONLINE),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          header(),
          Text(
            "Log in to your account",
            style: TextStyle(
              fontFamily: "Roboto",
              color: TEXT_PRIMARY,
              fontSize: 14,
            ),
          ),
          form(),
          Shared.button(
            height: 56,
            width: 186,
            title: "Log In",
            onPressed: () {
              BlocProvider.of<UserCubit>(context)
                  .loginUser(cred: _cred.text, pass: _pass.text);
            },
          ),
          Text(
            "Forgot your password?",
            style: TextStyle(
              fontFamily: "Roboto",
              color: NEUTRAL_PRIMARY_BASE,
              fontSize: 16,
            ),
          ),
          forgot(),
          signUp(context),
        ],
      ),
    );
  }
}
