import 'package:promdifarm_app/domain/entities/consignee.entity.dart';

class Consignee implements ConsigneeEntity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String avatar;
  final String birthdate;

  Consignee({
    this.id = "",
    this.email = "",
    this.firstName = "",
    this.phoneNumber = "",
    this.lastName = "",
    this.avatar = "",
    this.birthdate = "",
  });

  @override
  List<Object> get props =>
      [id, phoneNumber, email, firstName, lastName, avatar, birthdate];

  @override
  bool? get stringify => throw UnimplementedError();

  factory Consignee.fromJson(Map<String, dynamic> json) {
    return new Consignee(
      id: json["_id"] == null ? "" : json["_id"],
      email: json["email"] == null ? "" : json["email"],
      firstName: json["firstName"] == null ? "" : json["firstName"],
      lastName: json["lastName"] == null ? "" : json["lastName"],
      avatar: json["avatar"] == null ? "" : json["avatar"],
      birthdate: json["birthdate"] == null ? "" : json["birthdate"],
      phoneNumber: json["phoneNumber"] == null ? "" : json["phoneNumber"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "avatar": avatar,
      "birthdate": birthdate,
    };
  }
}
