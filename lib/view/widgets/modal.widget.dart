import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';

class BasicModal extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> children;

  const BasicModal({
    this.title = "",
    this.description = "",
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        ),
      ),
    );
  }
}

class LoadingModal extends BasicModal {
  LoadingModal({
    required String title,
    required String subtitle,
  }) : super(
          title: title,
          description: subtitle,
          children: [
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: TEXT_PRIMARY,
                          wordSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    flex: 3,
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: subtitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: TEXT_PRIMARY,
                          wordSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
}

class YesNoModal extends BasicModal {
  YesNoModal({
    required String title,
    required String subtitle,
    required Function(bool value) onAnswer,
    String buttonType = "normal",
  }) : super(
          title: title,
          description: subtitle,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: TEXT_PRIMARY,
                  wordSpacing: 1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: subtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: TEXT_PRIMARY,
                    wordSpacing: 1,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: buttonType == "normal"
                      ? PrimaryButton(
                          text: "Yes",
                          onPressed: () {
                            onAnswer(true);
                          },
                        )
                      : RedButton(
                          text: "Yes",
                          onPressed: () {
                            onAnswer(true);
                          },
                        ),
                ),
                Spacer(),
                Flexible(
                  flex: 6,
                  child: GrayButton(
                    text: "No",
                    onPressed: () {
                      onAnswer(false);
                    },
                  ),
                ),
              ],
            )
          ],
        );
}
