import 'package:promdifarm_app/data/models/consignee.model.dart';
import 'package:promdifarm_app/data/models/tenant.model.dart';
import 'package:promdifarm_app/domain/entities/parcels/parcel_item.entity.dart';
import 'package:promdifarm_app/domain/entities/parcels/parcel_location.entity.dart';

import '../base.entity.dart';

abstract class ParcelEntity extends BaseEntity {
  final String id;
  final ParcelLocationEntity pickupAddress;
  final ParcelLocationEntity shippingAddress;
  final List<ParcelItemEntity> items;
  final String refNum;
  final double weight;
  final Consignee consignee;
  final Tenant tenant;
  final List<dynamic> tracking;
  final String status;

  ParcelEntity({
    this.id = "",
    required this.pickupAddress,
    required this.shippingAddress,
    required this.items,
    required this.tenant,
    required this.consignee,
    this.refNum = "",
    this.weight = 0.00,
    this.tracking = const [],
    this.status = "",
  });
}
