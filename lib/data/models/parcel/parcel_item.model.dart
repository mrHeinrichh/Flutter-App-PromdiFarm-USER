import 'package:promdifarm_app/domain/entities/parcels/parcel_item.entity.dart';

class ParcelItem implements ParcelItemEntity {
  final String code;
  final String description;

  ParcelItem({
    this.code = "",
    this.description = "",
  });

  @override
  List<Object> get props => [
        code,
        description,
      ];

  factory ParcelItem.fromJson(Map<String, dynamic> json) {
    return new ParcelItem(
      code: json["code"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "description": description,
    };
  }

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
