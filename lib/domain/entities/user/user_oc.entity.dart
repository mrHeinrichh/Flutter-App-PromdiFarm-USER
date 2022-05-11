import 'package:flutter/widgets.dart';

import '../base.entity.dart';

@immutable
abstract class UserOREntity extends BaseEntity {
  final String image;
  final String number;

  UserOREntity({
    this.image = "",
    this.number = "",
  });
}
