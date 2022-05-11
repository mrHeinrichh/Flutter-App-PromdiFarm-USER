import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
part 'rider.state.dart';

class RiderCubit extends Cubit<RiderState> {
  final UsersRepository repository;

  RiderCubit({required this.repository}) : super(RiderInitial());

  void getProfile() {
    emit(GetProfileLoading());

    repository.getUserDetails().then(
      (res) {
        res.fold(
          (failure) => emit(GetProfileFail()),
          (success) => emit(GetProfileSuccess(user: success)),
        );
      },
    );
  }

  void updateProfile({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String email,
  }) {
    emit(UpdateProfileLoading());

    repository
        .updateProfile(
            firstName: firstName,
            lastName: lastName,
            birthDate: birthDate,
            email: email)
        .then(
      (res) {
        res.fold(
          (failure) => emit(UpdateProfileFail()),
          (success) => emit(UpdateProfileSuccess(response: success)),
        );
      },
    );
  }

  Future<void> openGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return emit(RiderInitial());

      repository.uploadAvatar(File(image.path)).then(
        (res) {
          res.fold(
            (failure) => emit(GetProfileFail()),
            (success) => emit(RiderInitial()),
          );
        },
      );
    } catch (e) {
      return emit(RiderInitial());
    }
  }

  void deleteImage() {
    emit(EditProfileDelete());
  }
}
