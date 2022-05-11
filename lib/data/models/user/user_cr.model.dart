import 'package:promdifarm_app/domain/entities/user/user_cr.entity.dart';

class UserCR implements UserCREntity {
  final String image;
  final String number;

  UserCR({
    this.image = "",
    this.number = "",
  });

  @override
  List<Object?> get props => [
        image,
        number,
      ];
  factory UserCR.fromJson(Map<String, dynamic> json) {
    return new UserCR(
      image: json["image"] ?? "",
      number: json["number"] ?? "",
    );
  }
  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
