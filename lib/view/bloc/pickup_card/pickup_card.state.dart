part of 'pickup_card.cubit.dart';

@immutable
abstract class PickUpCardState {}

// Initial state
class PickUpCardInitial extends PickUpCardState {}

class PickUpCardNoImage extends PickUpCardState {}

class PickUpCardHasImage extends PickUpCardState {
  final File image;
  PickUpCardHasImage(this.image);
}

class PickUpCardDelete extends PickUpCardState {}
