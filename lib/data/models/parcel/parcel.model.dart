import 'dart:io';
import 'package:promdifarm_app/data/models/address.model.dart';
import 'package:promdifarm_app/data/models/consignee.model.dart';
import 'package:promdifarm_app/data/models/parcel/parcel_item.model.dart';
import 'package:promdifarm_app/data/models/parcel/parcel_location.model.dart';
import 'package:promdifarm_app/data/models/tenant.model.dart';
import 'package:promdifarm_app/domain/entities/parcels/parcel.entity.dart';

class Parcel implements ParcelEntity {
  final String id;
  final ParcelLocation pickupAddress;
  final ParcelLocation shippingAddress;
  final List<ParcelItem> items;
  final String refNum;
  final double weight;
  final Consignee consignee;
  final Tenant tenant;
  final bool hasImage;
  final List<dynamic> tracking;
  final String status;
  final File? image;

  Parcel({
    this.id = "",
    required this.pickupAddress,
    required this.shippingAddress,
    required this.items,
    required this.tenant,
    required this.consignee,
    this.image,
    this.refNum = "",
    this.weight = 0.00,
    this.tracking = const [],
    this.status = "",
    this.hasImage = false,
  });

  @override
  List<Object> get props => [
        id,
        pickupAddress,
        shippingAddress,
        items,
        refNum,
        weight,
        consignee,
        tenant,
        tracking,
        status,
        hasImage,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  factory Parcel.fromJson(Map<String, dynamic> json) {
    List<ParcelItem> items = [];
    json["items"].forEach(
      (element) => items.add(
        ParcelItem.fromJson(element),
      ),
    );

    return Parcel(
      id: json["_id"] ?? "",
      pickupAddress: json["pickupAddress"] == null
          ? ParcelLocation(coordinates: [], address: Address())
          : ParcelLocation.fromJson(json["pickupAddress"]),
      shippingAddress: json["shippingAddress"] == null
          ? ParcelLocation(coordinates: [], address: Address())
          : ParcelLocation.fromJson(json["shippingAddress"]),
      items: items,
      refNum: json["refNum"] ?? "",
      weight: json["weight"] ?? 0.00,
      consignee: json["consignee"] == null
          ? Consignee()
          : Consignee.fromJson(json["consignee"]),
      tenant:
          json["tenant"] == null ? Tenant() : Tenant.fromJson(json["tenant"]),
      tracking: List<dynamic>.from(json["tracking"]),
      status: json["status"] ?? "",
      image: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "pickupAddress": pickupAddress,
      "shippingAddress": shippingAddress,
      "items": items,
      "refNum": refNum,
      "weight": weight,
      "consignee": consignee,
      "tenant": tenant,
      "tracking": tracking,
      "status": status,
      "image": image,
      "hasImage": hasImage,
    };
  }

  Parcel updateStatus(String myStatus) {
    return new Parcel(
      id: id,
      pickupAddress: pickupAddress,
      shippingAddress: shippingAddress,
      items: items,
      refNum: refNum,
      weight: weight,
      consignee: consignee,
      tenant: tenant,
      tracking: tracking,
      status: myStatus,
      hasImage: hasImage,
    );
  }
}
