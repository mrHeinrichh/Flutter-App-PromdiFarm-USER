import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/index.dart';

onTapped() {}

class SideNavTab extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final String asset;

  const SideNavTab({
    this.label = "",
    this.asset = "",
    this.onTap = onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            asset.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.network(
                      asset,
                      height: 16,
                      width: 16,
                      color: SECONDARY,
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: TEXT_PRIMARY,
                  fontFamily: 'Roboto',
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
