import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/rider-profile/rider.cubit.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: DARK,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(ROUTE.HOME_BACK);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90.0,
        color: NEUTRAL_PRIMARY_ACCENT,
        padding: const EdgeInsets.all(10),
        child: PrimaryButton(
          text: "EDIT PROFILE",
          onPressed: () {
            context.goNamed(ROUTE.EDITPROFILE);
          },
        ),
      ),
      body: BlocBuilder<RiderCubit, RiderState>(
        builder: (context, state) {
          if (state is RiderInitial || state is UpdateProfileSuccess) {
            BlocProvider.of<RiderCubit>(context).getProfile();
          }

          if (state is GetProfileSuccess) {
            return Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: DARK,
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: TEXT_LIGHT,
                          backgroundImage: NetworkImage('${state.user.avatar}'),
                          radius: 75.0,
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                      color: ACCENT,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${state.user.firstName} ${state.user.lastName}',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Motorcylce Driver',
                              style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1.4,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 90,
                              ),
                              child: Column(
                                children: [
                                  Divider(
                                    height: 18,
                                    thickness: 2,
                                    color: TEXT_PRIMARY,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Email: '),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('Birthday: '),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('License: '),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('OR: '),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('CR: '),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(state.user.email),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              formatter.format(
                                                DateTime.parse(
                                                    state.user.birthdate),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(state.user.license.number),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(state.user.or.number),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(state.user.cr.number),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                      color: ACCENT,
                    ),
                    Container(
                      height: 60.0,
                      child: Center(
                        child: Text(
                          "DELIVERY PARTNER",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: TEXT_LIGHT,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
