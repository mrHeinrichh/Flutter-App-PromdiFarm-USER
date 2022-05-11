import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'edit_profile.state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return emit(EditProfileNoImage());
      emit(EditProfileHasImage(File(image.path)));
    } catch (e) {
      return emit(EditProfileNoImage());
    }
  }

  void deleteImage() {
    emit(EditProfileDelete());
  }
}
