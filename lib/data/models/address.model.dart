import 'package:promdifarm_app/domain/entities/address.entity.dart';

class Address implements AddressEntity {
  final String id;
  final String description;
  final String fullAddress;
  final String type;

  Address({
    this.id = "",
    this.description = "",
    this.fullAddress = "",
    this.type = "",
  });

  @override
  List<Object> get props => [id, description, fullAddress, type];

  @override
  bool? get stringify => throw UnimplementedError();

  factory Address.fromJson(Map<String, dynamic> json) {
    return new Address(
      id: json["_id"] == null ? "" : json["_id"],
      description: json["description"] == null ? "" : json["description"],
      fullAddress: json["fullAddress"] == null ? "" : json["fullAddress"],
      type: json["type"] == null ? "" : json["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "fullAddress": fullAddress,
      "type": type,
    };
  }
}
