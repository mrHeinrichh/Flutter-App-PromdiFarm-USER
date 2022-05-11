import 'package:flutter/widgets.dart';
import 'package:promdifarm_app/domain/entities/location.entity.dart';
import 'package:promdifarm_app/domain/entities/parcels/parcel.entity.dart';
import 'base.entity.dart';

@immutable
abstract class DestinationEntity extends BaseEntity {
  final LocationEntity loc;
  final String id;
  final String type;
  final String name;
  final String address;
  final String payment;
  final String eta;
  final List<ParcelEntity> parcels;

  DestinationEntity({
    required this.loc,
    this.id = "",
    this.type = "",
    this.name = "",
    this.address = "",
    this.payment = "",
    this.eta = "",
    this.parcels = const [],
  });
}
