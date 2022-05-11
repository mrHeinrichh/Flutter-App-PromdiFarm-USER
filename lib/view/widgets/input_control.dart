import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';

class InputControl extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final int maxLines;

  InputControl({
    this.title = "",
    this.height = 35,
    this.width = 310,
    this.maxLines = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: TEXT_PRIMARY,
                fontSize: 13,
              ),
            ),
            Text(
              " *",
              style: TextStyle(
                color: RED,
                fontSize: 13,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Container(
          height: height,
          child: maxLines > 0
              ? TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 244, 246, 248),
                  ),
                )
              : TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: NEUTRAL_PRIMARY_ACCENT,
                  ),
                ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
