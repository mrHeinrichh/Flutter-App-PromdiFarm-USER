import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/data/models/parcel/parcel.model.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
part 'pickup_list.state.dart';

class PickUpListCubit extends Cubit<PickUpListState> {
  final ParcelRepository repository;
  List<Parcel> parcels = [];
  PickUpListCubit({required this.repository}) : super(PickUpListInitial([]));

  init(List<Parcel> parcels) {
    this.parcels = parcels;
    emit(PickUpListInitial(parcels));
  }

  void cancelItem(Parcel parcel) {
    emit(CancelItem(parcels));
    repository.cancelPickup([parcel]).then(
      (res) {
        res.fold(
            (failure) => emit(
                  CancelItemFail(this.parcels, failure),
                ), (success) {
          this.parcels =
              parcels.where((element) => element.id != parcel.id).toList();
          emit(CancelItemSuccess(parcels));
        });
      },
    );
  }

  void acceptItem(Parcel parcel) {
    emit(AcceptItem(parcels));

    repository.pickupParcel(parcel).then(
      (res) {
        res.fold(
            (failure) => emit(
                  AcceptItemFail(this.parcels, failure),
                ), (success) {
          this.parcels =
              parcels.where((element) => element.id != parcel.id).toList();
          emit(AcceptItemSuccess(parcels));
        });
      },
    );
  }

  void notPickUp(Parcel parcel) {
    parcels = parcels.where((element) => element.id != parcel.id).toList();
    emit(NotPickUp(parcels));
  }

  void addImage(String id, File image) {
    this.parcels = parcels.map((element) {
      if (element.id == id) {
        return Parcel(
          id: element.id,
          refNum: element.refNum,
          pickupAddress: element.pickupAddress,
          shippingAddress: element.shippingAddress,
          items: element.items,
          tenant: element.tenant,
          consignee: element.consignee,
          hasImage: true,
          image: image,
        );
      }
      return element;
    }).toList();
    emit(AddParcelImage(parcels));
  }

  void removeImage(String id) {
    this.parcels = parcels.map((element) {
      if (element.id == id) {
        return Parcel(
          id: element.id,
          pickupAddress: element.pickupAddress,
          shippingAddress: element.shippingAddress,
          items: element.items,
          tenant: element.tenant,
          consignee: element.consignee,
        );
      }
      return element;
    }).toList();
    emit(RemoveParcelImage(parcels));
  }

  finishPickUp(Destination destination) {
    emit(FinishPickup());
    repository.finishPickup(destination).then(
      (res) {
        res.fold(
          (failure) => emit(
            FinishPickupFail(parcels: parcels, error: failure),
          ),
          (success) => emit(
            FinishPickupSuccess(success),
          ),
        );
      },
    );
  }
}
