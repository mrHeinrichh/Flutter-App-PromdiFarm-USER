import 'package:flutter/widgets.dart';

import '../base.entity.dart';

@immutable
abstract class UserLicenseEntity extends BaseEntity {
  final String front;
  final String back;
  final String number;
  final String type;
  final String issuedDate;

  UserLicenseEntity({
    this.front = "",
    this.back = "",
    this.type = "",
    this.issuedDate = "",
    this.number = "",
  });
}
