import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:promdifarm_app/core/const/color.dart';

const Icon SUCCESS = Icon(
  Icons.check_circle_outlined,
  color: Colors.white,
  size: 32,
);

const Icon EXCLAMATION = Icon(
  Icons.error_outline_outlined,
  color: Colors.white,
  size: 32,
);

const Icon ERROR = Icon(
  Icons.cancel_outlined,
  color: Colors.white,
  size: 32,
);

class ToastInstance {
  final FToast fToast = FToast();

  void init(BuildContext context) {
    fToast.init(context);
  }

  void show({required ToastWidget toast}) {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}

class ToastWidget extends StatelessWidget {
  final String msg;
  final String status;
  final Icon icon;
  final Color bg;
  final Color textColor;
  static void onTap() {}

  ToastWidget({
    required this.msg,
    required this.status,
    required this.icon,
    required this.bg,
    this.textColor = TEXT_LIGHT,
    void Function() onTap = onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 21),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: bg,
      ),
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Center(
              child: Text(
                this.status,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              this.msg,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WhiteToast extends ToastWidget {
  static void onTap() {}

  WhiteToast({
    required String msg,
    required status,
    icon = SUCCESS,
    bg = TEXT_LIGHT,
    onTap = onTap,
  }) : super(
          msg: msg,
          icon: icon,
          status: status,
          bg: bg,
          onTap: onTap,
          textColor: NEUTRAL_SECONDARY_BASE,
        );
}

class SuccessToast extends ToastWidget {
  static void onTap() {}

  SuccessToast({
    required String msg,
    icon = SUCCESS,
    status = "Success",
    bg = DARK,
    onTap = onTap,
  }) : super(
          msg: msg,
          icon: icon,
          status: status,
          bg: bg,
          onTap: onTap,
        );
}

class WarningToast extends ToastWidget {
  static void onTap() {}

  WarningToast({
    required String msg,
    icon = EXCLAMATION,
    status = "Warning",
    bg = TINT_SECONDARY_DARK,
    onTap = onTap,
  }) : super(
          msg: msg,
          icon: icon,
          status: status,
          bg: bg,
          onTap: onTap,
        );
}

class ErrorToast extends ToastWidget {
  static void onTap() {}

  ErrorToast({
    required String msg,
    icon = ERROR,
    status = "Error",
    bg = RED,
    onTap = onTap,
  }) : super(
          msg: msg,
          icon: icon,
          status: status,
          bg: bg,
          onTap: onTap,
        );
}

class InfoToast extends ToastWidget {
  static void onTap() {}

  InfoToast({
    required String msg,
    icon = EXCLAMATION,
    status = "Info",
    bg = BLUE,
    onTap = onTap,
  }) : super(
          msg: msg,
          icon: icon,
          status: status,
          bg: bg,
          onTap: onTap,
        );
}
