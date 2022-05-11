import 'package:promdifarm_app/data/models/address.model.dart';

import '../base.entity.dart';

abstract class ParcelLocationEntity extends BaseEntity {
  final String type;
  final Address address;
  final List<double> coordinates;

  ParcelLocationEntity({
    this.type = "Point",
    required this.address,
    required this.coordinates,
  });
}
