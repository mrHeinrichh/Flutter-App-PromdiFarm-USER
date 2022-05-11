import 'package:promdifarm_app/domain/entities/tenant.entity.dart';

class Tenant implements TenantEntity {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;

  Tenant({
    this.id = "",
    this.email = "",
    this.name = "",
    this.phoneNumber = "",
  });

  @override
  List<Object> get props => [id, phoneNumber, email, name];

  @override
  bool? get stringify => throw UnimplementedError();

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return new Tenant(
      id: json["_id"] == null ? "" : json["_id"],
      email: json["email"] == null ? "" : json["email"],
      name: json["name"] == null ? "" : json["email"],
      phoneNumber: json["phoneNumber"] == null ? "" : json["phoneNumber"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "phoneNumber": phoneNumber,
    };
  }
}
