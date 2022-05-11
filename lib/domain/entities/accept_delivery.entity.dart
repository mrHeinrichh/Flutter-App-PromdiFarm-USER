import 'package:flutter/widgets.dart';
import 'base.entity.dart';
import 'destination.entity.dart';

@immutable
abstract class AcceptDeliveryEntity extends BaseEntity {
  final String id;
  final List<DestinationEntity> pending;
  final List<DestinationEntity> completed;
  final List<DestinationEntity> failed;

  AcceptDeliveryEntity({
    required this.id,
    required this.pending,
    required this.completed,
    required this.failed,
  });
}
