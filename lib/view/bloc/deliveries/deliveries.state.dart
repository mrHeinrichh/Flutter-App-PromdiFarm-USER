part of 'deliveries.cubit.dart';

@immutable
abstract class DeliveriesState {
  final List<Delivery> deliveries;
  DeliveriesState({this.deliveries = const []});
}

// Initial state
class DeliveriesInitial extends DeliveriesState {}

class DeliveriesStarted extends DeliveriesState {}

// Has an error
class DeliveriesFail extends DeliveriesState {
  final Failure error;
  final List<Delivery> deliveries;
  DeliveriesFail({required this.error, required this.deliveries})
      : super(deliveries: deliveries);
}

class DeliveriesLoading extends DeliveriesState {}

class DeliveriesLoaded extends DeliveriesState {
  final List<Delivery> deliveries;
  DeliveriesLoaded(this.deliveries) : super(deliveries: deliveries);
}

class GetDeliveriesSuccess extends DeliveriesState {
  final List<Delivery> deliveries;
  GetDeliveriesSuccess(this.deliveries) : super(deliveries: deliveries);
}

class LaunchMapSuccess extends DeliveriesState {}

class LaunchMapFailed extends DeliveriesState {}

class EndCurrentSession extends DeliveriesState {}

class EndCurrentSessionSuccess extends DeliveriesState {
  final List<Delivery> deliveries;
  EndCurrentSessionSuccess(this.deliveries) : super(deliveries: deliveries);
}

class RetryDelivery extends DeliveriesState {}

class RetryDeliverySuccess extends DeliveriesState {}

class RiderDeliveriesInitial extends DeliveriesState {}

class RiderDeliveriesLoading extends DeliveriesState {}

class RiderDeliveriesSuccess extends DeliveriesState {
  final List riderDeliveries;

  RiderDeliveriesSuccess({required this.riderDeliveries});
}

class RiderDeliveriesFail extends DeliveriesState {
  final Failure error;

  RiderDeliveriesFail({required this.error});
}
