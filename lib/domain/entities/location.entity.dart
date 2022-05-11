import 'package:flutter/widgets.dart';
import 'base.entity.dart';

@immutable
abstract class LocationEntity extends BaseEntity {
  final String type;
  final List<double> coordinates;

  LocationEntity({
    this.type = "Point",
    required this.coordinates,
  });
}
