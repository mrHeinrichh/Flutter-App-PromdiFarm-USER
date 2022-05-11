import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/bloc/slider/slider.cubit.dart';
import 'package:promdifarm_app/view/widgets/drawer/side_nav_header.widget.dart';
import 'package:promdifarm_app/view/widgets/drawer/side_nav_list.widget.dart';
import 'package:promdifarm_app/view/widgets/drawer/side_nav_tab.widget.dart';

class SideNav extends StatelessWidget {
  static void onTap() {}

  @override
  Widget build(BuildContext context) {
    final bloc = sl<SideNavCubit>();
    final tabs = [
      SideNavTab(
        label: "Profile",
        asset: ICON.PROFILE,
        onTap: () {
          Navigator.of(context).pop();
          context.goNamed(ROUTE.PROFILE);
        },
      ),
      SideNavTab(
        label: "History",
        asset: ICON.HISTORY,
        onTap: () {
          Navigator.of(context).pop();
          context.goNamed(ROUTE.RIDER_DELIVERIES);
        },
      ),
      Divider(),
      SideNavTab(
        label: "Settings",
        onTap: () {
          Navigator.of(context).pop();
          context.goNamed(ROUTE.SETTINGS);
        },
      ),
      SideNavTab(
        label: "Terms & Conditions / Privacy",
        onTap: () {
          Navigator.of(context).pop();
          context.goNamed(ROUTE.TERMS_PRIVACY);
        },
      ),
      SideNavTab(
        label: "Logout",
        onTap: () {
          bloc.logout().then((value) {
            BlocProvider.of<SliderCubit>(context).reset();
          });
        },
      ),
    ];

    return BlocProvider.value(
      value: bloc,
      child: Drawer(
        child: Column(
          children: [
            BlocBuilder<SideNavCubit, SideNavState>(
              builder: (context, state) {
                if (state is SideNavInitial) bloc.getUserCredentials();

                if (state is SideNavDone) {
                  return SideNavHeader(
                    fullName: '${state.firstName} ${state.lastName}',
                    avatar: state.avatar,
                  );
                }

                return SideNavHeader();
              },
            ),
            SideNavList(tabs: tabs),
          ],
        ),
      ),
    );
  }
}
