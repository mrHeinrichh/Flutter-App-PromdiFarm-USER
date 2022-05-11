import 'package:promdifarm_app/data/models/address.model.dart';
import 'package:promdifarm_app/domain/entities/parcels/parcel_location.entity.dart';

class ParcelLocation implements ParcelLocationEntity {
  final String type;
  final Address address;
  final List<double> coordinates;

  ParcelLocation({
    this.type = "Point",
    required this.address,
    required this.coordinates,
  });

  @override
  List<Object> get props => [
        type,
        address,
        coordinates,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  factory ParcelLocation.fromJson(Map<String, dynamic> json) {
    return new ParcelLocation(
      type: json["type"] == null ? "Point" : json["type"],
      address: json["address"] == null
          ? Address()
          : Address.fromJson(json["address"]),
      coordinates: json["coordinates"] == null
          ? []
          : [
              json["coordinates"][0],
              json["coordinates"][1],
            ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "address": address,
      "coordinates": coordinates,
    };
  }
}
