import 'package:flutter/widgets.dart';
import 'base.entity.dart';

@immutable
abstract class AddressEntity extends BaseEntity {
  final String id;
  final String fullAddress;
  final String type;
  final String description;

  AddressEntity({
    this.id = "",
    this.fullAddress = "",
    this.type = "",
    this.description = "",
  });
}
