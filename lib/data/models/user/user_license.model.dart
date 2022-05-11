import 'package:promdifarm_app/domain/entities/user/user_license.entity.dart';

class UserLicense implements UserLicenseEntity {
  final String front;
  final String back;
  final String number;
  final String type;
  final String issuedDate;

  UserLicense({
    this.front = "",
    this.back = "",
    this.number = "",
    this.type = "",
    this.issuedDate = "",
  });

  @override
  List<Object?> get props => [
        front,
        back,
        number,
        type,
        issuedDate,
      ];
  factory UserLicense.fromJson(Map<String, dynamic> json) {
    return new UserLicense(
      front: json["front"] ?? "",
      back: json["back"] ?? "",
      number: json["number"] ?? "",
      type: json["class"] ?? "",
      issuedDate: json["issuedDate"] ?? "",
    );
  }
  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
