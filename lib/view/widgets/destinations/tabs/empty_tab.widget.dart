import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';

class EmptyTab extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  final String title;
  final double titleSize;
  final String subtitle;
  final double subtitleSize;

  EmptyTab({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.subtitleSize = 14,
    this.titleSize = 25,
    this.imageSize = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Spacer(),
            Image.network(imageUrl, width: imageSize),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  color: NEUTRAL_PRIMARY_NORMAL,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: subtitleSize,
                  color: NEUTRAL_PRIMARY_NORMAL,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
