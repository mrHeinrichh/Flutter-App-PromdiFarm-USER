part of "home.cubit.dart";

@immutable
abstract class HomeState {
  final String route;
  final String title;
  final bool backButton;
  final bool enableBack;
  final double width;

  HomeState({
    this.route = "",
    this.title = "",
    this.backButton = false,
    this.enableBack = false,
    this.width = 0,
  });
}

// Initial state
class HomeInitial extends HomeState {
  HomeInitial() : super(title: "$PROJECT_NAME Rider", width: 30);
}

class AcceptDeliveryLoading extends HomeState {
  AcceptDeliveryLoading() : super(title: "$PROJECT_NAME Rider", width: 30);
}

class AcceptDeliveryFail extends HomeState {
  final Failure error;
  AcceptDeliveryFail({required this.error});
}

class AcceptDeliverySuccess extends HomeState {
  final AcceptDelivery acceptDelivery;
  AcceptDeliverySuccess(this.acceptDelivery)
      : super(
          route: "pending_delivery",
          title: "Pickups and Deliveries",
          enableBack: true,
        );
}

class GotoTabList extends HomeState {
  final String id;
  GotoTabList({required this.id})
      : super(title: "$PROJECT_NAME Rider", width: 30);
}

class GotoDestination extends HomeState {
  final Destination destination;
  final bool started;
  final bool arrived;

  GotoDestination({
    required this.destination,
    this.started = false,
    this.arrived = false,
    required String title,
  }) : super(
          route: "pending_delivery",
          title: title,
          enableBack: true,
          backButton: true,
          width: 30,
        );
}

class GotoFailedDestination extends HomeState {
  final Destination destination;
  GotoFailedDestination({required this.destination, required String title})
      : super(
          route: "failed_delivery",
          title: "Failed $title Items",
          enableBack: true,
          backButton: true,
          width: 30,
        );
}

class ProofOfDelivery extends HomeState {
  final Destination destination;
  ProofOfDelivery(this.destination)
      : super(
          title: "Proof of Delivery",
          enableBack: true,
        );
}

class PickupDelivery extends HomeState {
  final Destination destination;
  PickupDelivery(this.destination)
      : super(
          title: "Pickup Items",
          enableBack: true,
        );
}

class PendingDelivery extends HomeState {
  final AcceptDelivery acceptDelivery;
  PendingDelivery({required this.acceptDelivery})
      : super(
          title: "Pickups and Deliveries",
          enableBack: true,
        );
}

class DoneDelivery extends HomeState {
  final AcceptDelivery acceptDelivery;
  DoneDelivery({required this.acceptDelivery})
      : super(
          title: "Pickups and Deliveries",
          enableBack: true,
        );
}

class CompletedDelivery extends HomeState {
  final Destination destination;
  CompletedDelivery({required this.destination, required String title})
      : super(
          route: "done_delivery",
          title: title,
          enableBack: true,
          backButton: true,
          width: 30,
        );
}

class FailedDelivery extends HomeState {
  final AcceptDelivery acceptDelivery;
  FailedDelivery({required this.acceptDelivery})
      : super(
          title: "Pickups and Deliveries",
          enableBack: true,
        );
}

class EndDelivery extends HomeState {
  EndDelivery() : super(title: "$PROJECT_NAME Rider", width: 30);
}

class StartedDelivery extends HomeState {
  StartedDelivery({required String title})
      : super(title: title, enableBack: true);
}

class ArrivedDestination extends HomeState {
  ArrivedDestination({required String title})
      : super(title: title, enableBack: true);
}
