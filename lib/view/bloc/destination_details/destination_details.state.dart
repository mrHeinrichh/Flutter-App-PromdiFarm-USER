part of 'destination_details.cubit.dart';

@immutable
abstract class DestinationDetailsState {}

// Initial state
class DestinationDetailsInitial extends DestinationDetailsState {}

class DestinationDetailsStarted extends DestinationDetailsState {}

class DestinationDetailsSuccess extends DestinationDetailsState {}

class DestinationDetailsFail extends DestinationDetailsState {
  final Failure error;
  DestinationDetailsFail({required this.error});
}

class DestinationDeliveredStarted extends DestinationDetailsState {}

class DestinationDeliveredFail extends DestinationDetailsState {
  final Failure error;
  DestinationDeliveredFail({required this.error});
}

class DestinationDeliveredSuccess extends DestinationDetailsState {}

class DestinationDetailsCancel extends DestinationDetailsState {}

class DestinationDetailsCancelSuccess extends DestinationDetailsState {
  final AcceptDelivery acceptDelivery;
  DestinationDetailsCancelSuccess(this.acceptDelivery);
}

class DestinationArrivedStarted extends DestinationDetailsState {}

class DestinationArrivedSuccess extends DestinationDetailsState {}

class DestinationArrivedFail extends DestinationDetailsState {
  final Failure error;
  DestinationArrivedFail({required this.error});
}

class DestinationPickupStarted extends DestinationDetailsState {}

class DestinationPickupFail extends DestinationDetailsState {
  final Failure error;
  DestinationPickupFail({required this.error});
}

class DestinationPickupSuccess extends DestinationDetailsState {}
