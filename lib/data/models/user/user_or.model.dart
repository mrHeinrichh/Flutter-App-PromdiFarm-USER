import 'package:promdifarm_app/domain/entities/user/user_oc.entity.dart';

class UserOR implements UserOREntity {
  final String image;
  final String number;

  UserOR({
    this.image = "",
    this.number = "",
  });

  @override
  List<Object?> get props => [
        image,
        number,
      ];
  factory UserOR.fromJson(Map<String, dynamic> json) {
    return new UserOR(
      image: json["image"] ?? "",
      number: json["number"] ?? "",
    );
  }
  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
