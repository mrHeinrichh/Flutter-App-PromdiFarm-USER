import 'package:flutter/widgets.dart';

import '../base.entity.dart';

@immutable
abstract class UserCREntity extends BaseEntity {
  final String image;
  final String number;

  UserCREntity({
    this.image = "",
    this.number = "",
  });
}
