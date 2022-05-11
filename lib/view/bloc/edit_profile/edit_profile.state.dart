part of 'edit_profile.cubit.dart';

@immutable
abstract class EditProfileState {}

// Initial state
class EditProfileInitial extends EditProfileState {}

class EditProfileNoImage extends EditProfileState {}

class EditProfileHasImage extends EditProfileState {
  final File image;
  EditProfileHasImage(this.image);
}

class EditProfileDelete extends EditProfileState {}
