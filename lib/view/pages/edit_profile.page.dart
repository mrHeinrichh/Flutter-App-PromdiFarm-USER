import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/view/bloc/rider-profile/rider.cubit.dart';
import 'package:promdifarm_app/view/widgets/buttons.widget.dart';
import 'package:promdifarm_app/view/widgets/modal.widget.dart';
import 'package:promdifarm_app/view/widgets/shared.dart';
import 'package:promdifarm_app/view/widgets/text_field.widget.dart';

class EditProfile extends StatelessWidget {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final birthDate = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Edit Profile"),
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
          text: "CONFIRM",
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext ctx) {
                return YesNoModal(
                  buttonType: "danger",
                  title: "Update Profile",
                  subtitle: "Are you sure you want to save your changes?",
                  onAnswer: (value) {
                    if (value) {
                      BlocProvider.of<RiderCubit>(context).updateProfile(
                          firstName: firstName.text,
                          lastName: lastName.text,
                          birthDate: birthDate.text,
                          email: email.text);
                      context.goNamed(ROUTE.PROFILE);
                    }
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        ),
      ),
      body: BlocBuilder<RiderCubit, RiderState>(
        builder: (context, state) {
          if (state is RiderInitial) {
            BlocProvider.of<RiderCubit>(context).getProfile();
          }
          if (state is GetProfileSuccess) {
            return ListView(
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: DARK,
                                        width: 8,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: TEXT_LIGHT,
                                      backgroundImage:
                                          NetworkImage('${state.user.avatar}'),
                                      radius: 60.0,
                                    ),
                                  ),
                                  ButtonTheme(
                                    minWidth: 85.0,
                                    height: 25.0,
                                    child: RaisedButton(
                                      onPressed: () {
                                        BlocProvider.of<RiderCubit>(context)
                                            .openGallery();
                                      },
                                      color: NEUTRAL_PRIMARY_ACCENT,
                                      child: Text(
                                        "Select Image",
                                        style: TextStyle(
                                          color: NEUTRAL_SECONDARY_BASE,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            textlabel(txtlabel: "Rider Information"),
                            Row(
                              children: [
                                Shared.shortTextField(
                                  controller: firstName,
                                  width: FIELD_SHORT_WIDTH,
                                  tagName: "First Name:",
                                  label: "${state.user.firstName}",
                                ),
                                Spacer(),
                                Shared.shortTextField(
                                  controller: lastName,
                                  width: FIELD_SHORT_WIDTH,
                                  tagName: "Last Name:",
                                  label: "${state.user.lastName}",
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                BirthDate(
                                  width: FIELD_SHORT_WIDTH,
                                  tagName: "Birthdate:",
                                  controller: birthDate,
                                ),
                                Spacer(),
                                Shared.shortTextField(
                                  controller: email,
                                  width: FIELD_SHORT_WIDTH,
                                  tagName: "Email:",
                                  label: "${state.user.email}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget textlabel({String txtlabel = ""}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Row(
        children: [
          Text(
            txtlabel,
            style: TextStyle(color: RED, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
