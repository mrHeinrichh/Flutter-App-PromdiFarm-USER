import 'package:promdifarm_app/domain/entities/index.dart';
import 'destination.model.dart';
import 'location.model.dart';

class Delivery implements DeliveryEntity {
  final String id;
  final String code;
  final String status;
  final Location start;
  final Location end;
  final List<String> parcels;
  final List<Destination> destinations;
  final bool deleted;

  Delivery({
    required this.id,
    required this.code,
    required this.start,
    required this.end,
    required this.destinations,
    required this.deleted,
    required this.parcels,
    required this.status,
  });

  @override
  List<Object> get props => [
        id,
        start,
        end,
        destinations,
        deleted,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  factory Delivery.fromJson(Map<String, dynamic> json) {
    List<Destination> destinations = [];
    json["destinations"].forEach(
      (element) => destinations.add(
        Destination.fromJson(element),
      ),
    );

    return new Delivery(
      id: json["_id"] == null ? "" : json["_id"],
      code: json["code"] == null ? "" : json["code"],
      status: json["status"] == null ? "" : json["status"],
      start: json["start"] == null
          ? new Location(coordinates: [])
          : new Location.fromJson(json["start"]),
      end: json["end"] == null
          ? new Location(coordinates: [])
          : new Location.fromJson(json["end"]),
      destinations: destinations,
      parcels: json["parcels"] == null
          ? []
          : json["parcels"].map<String>((e) => e.toString()).toList(),
      deleted: json["deleted"] == null ? json["deleted"] : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "start": start,
      "end": end,
      "parcels": parcels,
      "status": status,
      "destinations": destinations,
      "deleted": deleted
    };
  }

  Delivery updateDestParcelStatus(List<String> myParcels, String parcelStatus) {
    return new Delivery(
      id: id,
      code: code,
      start: start,
      end: end,
      destinations: destinations.map((destination) {
        return destination.updateParcels(destination.parcels.map((parcel) {
          if (myParcels.contains(parcel.id)) {
            return parcel.updateStatus(parcelStatus);
          }
          return parcel;
        }).toList());
      }).toList(),
      deleted: deleted,
      parcels: parcels,
      status: status,
    );
  }
}
