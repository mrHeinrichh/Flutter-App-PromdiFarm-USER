import '../base.entity.dart';

abstract class ParcelItemEntity extends BaseEntity {
  final String code;
  final String description;

  ParcelItemEntity({
    this.code = "",
    this.description = "",
  });
}
