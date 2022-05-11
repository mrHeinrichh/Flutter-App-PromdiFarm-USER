import 'package:promdifarm_app/domain/entities/location.entity.dart';

class Location implements LocationEntity {
  final String type;
  final List<double> coordinates;

  Location({
    this.type = "Point",
    required this.coordinates,
  });

  @override
  List<Object> get props => [
        type,
        coordinates,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  factory Location.fromJson(Map<String, dynamic> json) {
    return new Location(
      type: json["type"] == null ? "Point" : json["type"],
      coordinates: json["coordinates"] == null
          ? []
          : [
              json["coordinates"][0],
              json["coordinates"][1],
            ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "coordinates": coordinates,
    };
  }
}
