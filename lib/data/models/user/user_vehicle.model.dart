import 'package:promdifarm_app/domain/entities/user/user_vehicle.entity.dart';

class UserVehicle implements UserVehicleEntity {
  final String type;
  final String model;
  final String plateNumber;
  final String color;

  UserVehicle({
    this.type = "",
    this.model = "",
    this.plateNumber = "",
    this.color = "",
  });

  @override
  List<Object?> get props => [
        type,
        model,
        plateNumber,
        color,
      ];

  factory UserVehicle.fromJson(Map<String, dynamic> json) {
    return new UserVehicle(
      type: json["type"] ?? "",
      model: json["model"] ?? "",
      plateNumber: json["plateNumber"] ?? "",
      color: json["color"] ?? "",
    );
  }

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
