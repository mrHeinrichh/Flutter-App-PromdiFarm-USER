import 'package:flutter/widgets.dart';
import 'destination.entity.dart';
import 'location.entity.dart';
import 'base.entity.dart';

@immutable
abstract class DeliveryEntity extends BaseEntity {
  final String id;
  final LocationEntity start;
  final LocationEntity end;
  final List<String> parcels;
  final List<DestinationEntity> destinations;
  final bool deleted;

  DeliveryEntity({
    required this.id,
    required this.start,
    required this.end,
    required this.parcels,
    required this.destinations,
    required this.deleted,
  });

  Map<String, dynamic> toJson();
}
