import 'package:flutter/material.dart';

class SideNavList extends StatelessWidget {
  final List<Widget> tabs;

  const SideNavList({required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: tabs,
      ),
    );
  }
}
