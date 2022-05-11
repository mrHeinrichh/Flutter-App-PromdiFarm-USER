import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/const/numbers.dart';
import 'package:promdifarm_app/view/bloc/delivery_proof/delivery_proof.cubit.dart';
import 'package:promdifarm_app/view/widgets/drawer/side_nav.widget.dart';

class Shared {
  static void onPressed() {}
  static void onChanged() {}
  static void onTap() {}
  static FToast fToast = FToast();

  static Widget template({
    required BuildContext context,
    required Widget body,
    required String title,
  }) {
    return Scaffold(
      appBar: appBar(title: title),
      body: Center(
        child: body,
      ),
      drawer: SideNav(),
    );
  }

  static PreferredSizeWidget appBar({
    required String title,
  }) {
    return AppBar(
      title: Text(title),
      backgroundColor: DARK,
    );
  }

  static Widget toast({
    String text = "",
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: DARK,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(
            text,
            style: TextStyle(
              color: TEXT_LIGHT,
            ),
          ),
        ],
      ),
    );
  }

  static Widget button({
    double height = 10,
    double width = 10,
    String title = "",
    void Function() onPressed = onPressed,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: DARK,
          onPrimary: TEXT_LIGHT,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(31),
          ),
          elevation: 8.0,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  static Widget textField({
    double width = FIELD_WIDTH,
    String label = "",
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(89.0)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: NEUTRAL_PRIMARY_ACCENT,
          labelText: label,
        ),
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          color: TEXT_PRIMARY,
        ),
        maxLines: 1,
      ),
    );
  }

  static Widget shortTextField({
    double width = FIELD_WIDTH,
    String tagName = "",
    String label = "",
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tagName,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: width,
              height: 25,
              child: TextField(
                obscureText: obscureText,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: NEUTRAL_PRIMARY_ACCENT,
                  labelText: label,
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: TEXT_PRIMARY,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget VehicleTextField({
    double width = FIELD_WIDTH,
    String tagName = "",
    String label = "",
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tagName,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: width,
              height: 25,
              child: TextField(
                obscureText: obscureText,
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.motorcycle_outlined,
                      size: 20,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: NEUTRAL_PRIMARY_ACCENT,
                  labelText: label,
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: TEXT_PRIMARY,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget ColorTextField({
    double width = FIELD_WIDTH,
    String tagName = "",
    String label = "",
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tagName,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: width,
              height: 25,
              child: TextField(
                obscureText: obscureText,
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.color_lens_outlined,
                      size: 20,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: NEUTRAL_PRIMARY_ACCENT,
                  labelText: label,
                ),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: TEXT_PRIMARY,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget listTitle({
    String label = "",
    String asset = "",
    void Function() onTap = onTap,
  }) {
    return SizedBox(
      child: ListTile(
        leading: Image.network(
          asset,
          height: 27,
          width: 27,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: TEXT_PRIMARY,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
