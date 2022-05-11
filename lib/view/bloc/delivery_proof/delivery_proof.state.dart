part of 'delivery_proof.cubit.dart';

@immutable
abstract class DeliveryProofState {}

// Initial state
class DeliveryProofInitial extends DeliveryProofState {}

class DeliveryProofFail extends DeliveryProofState {
  final Failure error;
  DeliveryProofFail({required this.error});
}

class OpenCamera extends DeliveryProofState {}

class NoImage extends DeliveryProofState {}

class HasImage extends DeliveryProofState {
  final File image;
  HasImage(this.image);
}

class DeleteImage extends DeliveryProofState {}

class CompletingDelivery extends DeliveryProofState {}

class CompletingDeliverySuccess extends DeliveryProofState {
  final AcceptDelivery acceptDelivery;
  CompletingDeliverySuccess(this.acceptDelivery);
}
