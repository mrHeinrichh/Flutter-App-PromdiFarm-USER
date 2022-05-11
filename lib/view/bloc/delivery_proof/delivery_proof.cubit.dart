import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/accept_delivery.model.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';

part 'delivery_proof.state.dart';

class DeliveryProofCubit extends Cubit<DeliveryProofState> {
  final DeliveriesRepository repository;

  DeliveryProofCubit({required this.repository})
      : super(DeliveryProofInitial());

  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return emit(NoImage());

    emit(HasImage(File(image.path)));
  }

  void deleteImage() {
    emit(DeleteImage());
  }

  reset() {
    emit(DeliveryProofInitial());
  }

  void completeDelivery(Destination destination, File image) {
    emit(CompletingDelivery());

    repository.completeDelivery(destination, image).then(
      (res) {
        res.fold(
          (failure) => emit(DeliveryProofFail(error: failure)),
          (success) => emit(CompletingDeliverySuccess(success)),
        );
      },
    );
  }
}
