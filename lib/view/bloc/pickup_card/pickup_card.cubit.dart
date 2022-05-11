import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'pickup_card.state.dart';

class PickUpCardCubit extends Cubit<PickUpCardState> {
  PickUpCardCubit() : super(PickUpCardInitial());

  Future<void> openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return emit(PickUpCardNoImage());
      emit(PickUpCardHasImage(File(image.path)));
    } catch (e) {
      return emit(PickUpCardNoImage());
    }
  }

  void deleteImage() {
    emit(PickUpCardDelete());
  }
}
