part of 'pickup_list.cubit.dart';

@immutable
abstract class PickUpListState {
  final List<Parcel> parcels;
  PickUpListState(this.parcels);
}

class PickUpListInitial extends PickUpListState {
  PickUpListInitial(List<Parcel> parcels) : super(parcels);
}

class AcceptItem extends PickUpListState {
  AcceptItem(List<Parcel> parcels) : super(parcels);
}

class CancelItemFail extends PickUpListState {
  final Failure error;
  CancelItemFail(List<Parcel> parcels, this.error) : super(parcels);
}

class CancelItem extends PickUpListState {
  CancelItem(List<Parcel> parcels) : super(parcels);
}

class CancelItemSuccess extends PickUpListState {
  CancelItemSuccess(List<Parcel> parcels) : super(parcels);
}

class AcceptItemFail extends PickUpListState {
  final Failure error;
  AcceptItemFail(List<Parcel> parcels, this.error) : super(parcels);
}

class AcceptItemSuccess extends PickUpListState {
  AcceptItemSuccess(List<Parcel> parcels) : super(parcels);
}

class NotPickUp extends PickUpListState {
  NotPickUp(List<Parcel> parcels) : super(parcels);
}

class AddParcelImage extends PickUpListState {
  AddParcelImage(List<Parcel> parcels) : super(parcels);
}

class RemoveParcelImage extends PickUpListState {
  RemoveParcelImage(List<Parcel> parcels) : super(parcels);
}

class FinishPickup extends PickUpListState {
  FinishPickup() : super([]);
}

class FinishPickupSuccess extends PickUpListState {
  final AcceptDelivery acceptDelivery;
  FinishPickupSuccess(this.acceptDelivery) : super([]);
}

class FinishPickupFail extends PickUpListState {
  final Failure error;
  FinishPickupFail({required this.error, required List<Parcel> parcels})
      : super(parcels);
}
