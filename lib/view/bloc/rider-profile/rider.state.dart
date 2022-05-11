part of 'rider.cubit.dart';

@immutable
abstract class RiderState {}

class RiderInitial extends RiderState {}

// Profile RIder
class GetProfileInitial extends RiderState {}

class GetProfileLoading extends RiderState {}

class GetProfileSuccess extends RiderState {
  final User user;
  GetProfileSuccess({required this.user});
}

class GetProfileFail extends RiderState {}

class EditProfileInitial extends RiderState {}

class EditProfileNoImage extends RiderState {}

class EditProfileHasImage extends RiderState {
  final User user;
  EditProfileHasImage({required this.user});
}

class UpdateProfileFail extends RiderState {}

class UpdateProfileInitial extends RiderState {}

class UpdateProfileLoading extends RiderState {}

class UpdateProfileSuccess extends RiderState {
  final Response response;
  UpdateProfileSuccess({required this.response});
}

class EditProfileDelete extends RiderState {}
