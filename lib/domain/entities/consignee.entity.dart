import 'package:flutter/widgets.dart';
import 'base.entity.dart';

@immutable
abstract class ConsigneeEntity extends BaseEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String avatar;
  final String email;
  final String birthdate;

  ConsigneeEntity({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.phoneNumber = "",
    this.avatar = "",
    this.email = "",
    this.birthdate = "",
  });
}
