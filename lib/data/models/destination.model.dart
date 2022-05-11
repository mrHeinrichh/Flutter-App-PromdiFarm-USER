import 'package:promdifarm_app/domain/entities/index.dart';
import 'location.model.dart';
import 'parcel/parcel.model.dart';

class Destination implements DestinationEntity {
  final Location loc;
  final String id;
  final String type;
  final String name;
  final String eta;
  final String address;
  final String payment;
  final String status;
  final List<Parcel> parcels;

  Destination({
    required this.loc,
    this.id = "",
    this.type = "",
    this.name = "",
    this.eta = "9:00 AM - 10:00 AM",
    this.address = "",
    this.payment = "",
    this.status = "",
    this.parcels = const [],
  });

  @override
  List<Object> get props => [
        loc,
        id,
        type,
        name,
        eta,
        address,
        payment,
        parcels,
        status,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  factory Destination.fromJson(Map<String, dynamic> json) {
    List<double> coordinates = json["coordinates"] != null
        ? [json["coordinates"][0], json["coordinates"][1]]
        : [];
    String type = json["type"] ?? "";

    List<Parcel> parcels = [];
    json["parcels"].forEach(
      (element) => parcels.add(
        Parcel.fromJson(element),
      ),
    );

    return new Destination(
      loc: new Location(coordinates: coordinates),
      id: json["_id"] ?? "",
      type: type,
      name: json["name"] ?? "",
      eta: json["eta"] ?? "0 min",
      address: json["title"] ?? "",
      status: json["status"] ?? "",
      payment: json["payment"] ?? type.toLowerCase().contains("ship")
          ? "Cash on Delivery"
          : "None",
      parcels: parcels,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "loc": loc.toJson(),
      "id": id,
      "type": type,
      "name": name,
      "eta": eta,
      "address": address,
      "payment": payment,
      "status": status,
    };
  }

  Destination filterParcelsStatus(String status) {
    List<Parcel> list = parcels
        .where((e) => e.status.toLowerCase() != status.toLowerCase())
        .toList();

    return new Destination(
      loc: loc,
      id: id,
      type: type,
      name: name,
      eta: eta,
      address: address,
      status: status,
      payment: payment,
      parcels: list,
    );
  }

  Destination updateParcels(List<Parcel> myParcels) {
    return new Destination(
      loc: loc,
      id: id,
      type: type,
      name: name,
      eta: eta,
      address: address,
      status: status,
      payment: payment,
      parcels: myParcels,
    );
  }
}
