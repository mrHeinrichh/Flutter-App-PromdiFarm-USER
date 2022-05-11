import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
part 'destination_details.state.dart';

class DestinationDetailsCubit extends Cubit<DestinationDetailsState> {
  final ParcelRepository repository;

  DestinationDetailsCubit(this.repository) : super(DestinationDetailsInitial());

  startDelivery(Destination destination) {
    emit(DestinationDetailsStarted());
    repository.movingDelivery(destination).then(
      (res) {
        res.fold(
          (failure) => emit(
            DestinationDetailsFail(error: failure),
          ),
          (success) => emit(
            DestinationDetailsSuccess(),
          ),
        );
      },
    );
  }

  arrived(Destination destination) {
    repository.arrivedDelivery(destination).then(
      (res) {
        res.fold(
          (failure) => emit(
            DestinationArrivedFail(error: failure),
          ),
          (success) => emit(
            DestinationArrivedSuccess(),
          ),
        );
      },
    );
  }

  cancelDelivery(Destination destination) {
    emit(DestinationDetailsCancel());
    repository.cancelDelivery(destination).then(
      (res) {
        res.fold(
          (failure) => emit(DestinationDetailsFail(error: failure)),
          (success) => emit(DestinationDetailsCancelSuccess(success)),
        );
      },
    );
  }

  cancelPickup(Destination destination) {
    emit(DestinationDetailsCancel());
    repository.cancelPickup(destination.parcels).then(
      (res) {
        res.fold(
          (failure) => emit(DestinationDetailsFail(error: failure)),
          (success) => emit(DestinationDetailsCancelSuccess(success)),
        );
      },
    );
  }

  reset() {
    emit(DestinationDetailsInitial());
  }
}
