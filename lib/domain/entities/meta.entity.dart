import 'package:flutter/widgets.dart';
import 'base.entity.dart';

@immutable
abstract class MetaEntity extends BaseEntity {
  final String token;
  final String refresh;

  MetaEntity({this.token = "", this.refresh = ""});
}
