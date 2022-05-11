import 'package:flutter/widgets.dart';

import '../base.entity.dart';

@immutable
abstract class UserVehicleEntity extends BaseEntity {
  final String type;
  final String model;
  final String plateNumber;
  final String color;

  UserVehicleEntity({
    this.type = "",
    this.model = "",
    this.plateNumber = "",
    this.color = "",
  });
}
