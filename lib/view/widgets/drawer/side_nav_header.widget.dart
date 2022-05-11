import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/index.dart';

class SideNavHeader extends StatelessWidget {
  final String fullName;
  final String avatar;

  const SideNavHeader({
    this.fullName = '',
    this.avatar = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      width: double.maxFinite,
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: SECONDARY,
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              avatar.isNotEmpty
                  ? CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(avatar),
                      backgroundColor: TEXT_LIGHT,
                    )
                  : Container(),
              Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: TEXT_LIGHT,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
