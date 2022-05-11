import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
part 'deliveries.state.dart';

class DeliveriesCubit extends Cubit<DeliveriesState> {
  final DeliveriesRepository repository;

  DeliveriesCubit({required this.repository}) : super(DeliveriesInitial());

  void getAvailableDeliveries() {
    emit(DeliveriesLoading());

    repository.listDeliveries().then(
      (res) {
        res.fold(
          (failure) => emit(DeliveriesFail(
            deliveries: repository.list,
            error: failure,
          )),
          (success) => emit(GetDeliveriesSuccess(success)),
        );
      },
    );
  }

  void startDelivery() {
    repository.launchMap().then(
      (res) {
        res.fold(
          (failure) => emit(DeliveriesFail(
            deliveries: repository.list,
            error: failure,
          )),
          (success) {
            success ? emit(LaunchMapSuccess()) : emit(LaunchMapFailed());
          },
        );
      },
    );
  }

  void retryDelivery(Destination destination) {
    emit(RetryDelivery());

    repository.retryDelivery(destination).then(
      (res) {
        res.fold(
          (failure) => emit(DeliveriesFail(
            deliveries: repository.list,
            error: failure,
          )),
          (success) => emit(RetryDeliverySuccess()),
        );
      },
    );
  }

  void endDelivery() {
    emit(EndCurrentSession());

    repository.endDelivery().then(
      (res) {
        res.fold(
          (failure) => emit(DeliveriesFail(
            deliveries: repository.list,
            error: failure,
          )),
          (success) => emit(EndCurrentSessionSuccess(success)),
        );
      },
    );
  }

  void updateDestinationStatus({
    required List<String> destinations,
    required String status,
  }) {
    repository
        .updateDestinationStatus(destinations: destinations, status: status)
        .then(
      (res) {
        res.fold(
          (failure) => emit(DeliveriesFail(
            deliveries: repository.list,
            error: failure,
          )),
          (success) => emit(DeliveriesStarted()),
        );
      },
    );
  }

  reset() {
    emit(DeliveriesInitial());
  }

  void getRiderDeliveries() {
    emit(RiderDeliveriesLoading());

    repository.getRiderDeliveries().then(
      (res) {
        res.fold(
          (failure) => emit(RiderDeliveriesFail(error: failure)),
          (success) => emit(RiderDeliveriesSuccess(riderDeliveries: success)),
        );
      },
    );
  }
}
