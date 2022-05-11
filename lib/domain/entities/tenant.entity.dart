import 'package:flutter/widgets.dart';
import 'base.entity.dart';

@immutable
abstract class TenantEntity extends BaseEntity {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  TenantEntity({
    this.id = "",
    this.name = "",
    this.email = "",
    this.phoneNumber = "",
  });
}
