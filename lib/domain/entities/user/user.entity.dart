import 'package:flutter/widgets.dart';
import 'package:promdifarm_app/domain/entities/user/user_license.entity.dart';
import 'package:promdifarm_app/domain/entities/user/user_oc.entity.dart';

import '../base.entity.dart';
import 'user_cr.entity.dart';
import 'user_vehicle.entity.dart';

@immutable
abstract class UserEntity extends BaseEntity {
  final String firstName;
  final String lastName;
  final String email;
  final List roles;
  final String avatar;
  final UserLicenseEntity license;
  final UserCREntity cr;
  final UserOREntity or;
  final String birthdate;
  final UserVehicleEntity vehicle;
  final List tenants;
  final String lastLogin;
  final String type;
  final String phoneNumber;
  final String address;
  final String status;

  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.vehicle,
    required this.or,
    required this.cr,
    required this.license,
    this.birthdate = "",
    this.email = "",
    this.lastLogin = "",
    this.type = "",
    this.phoneNumber = "",
    this.address = "",
    this.status = "",
    this.roles = const [],
    this.tenants = const [],
  });
}
