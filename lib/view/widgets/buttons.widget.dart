import 'package:flutter/material.dart';
import '../../core/const/color.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Color highlight;
  final Color outline;
  final Function() onPressed;

  static void Function() press = () {};

  MainButton({
    this.text = "",
    this.textColor = TEXT_LIGHT,
    this.highlight = TEXT_LIGHT,
    this.outline = DARK,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: highlight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: outline, width: 1.5),
        ),
        elevation: 3.0,
        minimumSize: Size(double.maxFinite, 50),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
        ),
      ),
    );
  }
}

class PrimaryButton extends MainButton {
  PrimaryButton({text = "", required onPressed})
      : super(
          text: text,
          color: DARK,
          highlight: TEXT_DARK,
          outline: DARK,
          onPressed: onPressed,
        );
}

class SecondaryButton extends MainButton {
  SecondaryButton({text = "", required onPressed})
      : super(text: text, color: SECONDARY, onPressed: onPressed);
}

class WhiteButton extends MainButton {
  WhiteButton({text = "", required onPressed})
      : super(
          text: text,
          textColor: DARK,
          color: NEUTRAL_PRIMARY_ACCENT,
          onPressed: onPressed,
        );
}

class GrayButton extends MainButton {
  GrayButton({text = "", required onPressed})
      : super(
          text: text,
          textColor: NEUTRAL_PRIMARY_NORMAL,
          outline: NEUTRAL_PRIMARY_NORMAL,
          color: NEUTRAL_PRIMARY_ACCENT,
          onPressed: onPressed,
        );
}

class RedButton extends MainButton {
  RedButton({text = "", required onPressed})
      : super(
          text: text,
          outline: Colors.red,
          color: Colors.red,
          onPressed: onPressed,
        );
}
