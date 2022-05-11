import 'package:bloc/bloc.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:meta/meta.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DeliveriesRepository repository;

  HomeCubit({required this.repository}) : super(HomeInitial());

  goto(String view, {dynamic params}) {
    if (view == 'tab_list') {
      emit(GotoTabList(id: params));
    } else if (view == 'pending_delivery') {
      emit(PendingDelivery(acceptDelivery: repository.acceptedDelivery));
    } else if (view == 'destination') {
      final isPickup =
          params["destination"].type.toLowerCase().contains("pickup");
      final title = (isPickup ? "Pickup" : "Delivery") + " Information";

      emit(GotoDestination(
        destination: params["destination"],
        started: params["started"] ?? false,
        arrived: params["arrived"] ?? false,
        title: title,
      ));
    } else if (view == 'arrived_destination') {
      emit(ArrivedDestination(title: params));
    } else if (view == 'proof_of_delivery') {
      emit(ProofOfDelivery(params));
    } else if (view == 'pickup_delivery') {
      emit(PickupDelivery(params));
    } else if (view == 'done_delivery' || view == 'done_pickup') {
      if (params != null) repository.acceptedDelivery = params;
      emit(DoneDelivery(acceptDelivery: params ?? repository.acceptedDelivery));
    } else if (view == 'failed_delivery') {
      if (params != null) repository.acceptedDelivery = params;
      emit(
        FailedDelivery(acceptDelivery: params ?? repository.acceptedDelivery),
      );
    } else if (view == 'failed_destination') {
      final isPickup = params.type.toLowerCase().contains("pickup");
      emit(
        GotoFailedDestination(
          destination: params,
          title: isPickup ? "Pickup" : "Delivery",
        ),
      );
    } else if (view == 'completed_delivery') {
      final isPickup = params.type.toLowerCase().contains("pickup");
      final title =
          "Completed " + (isPickup ? "Pickup Items" : "Delivery Info");
      emit(CompletedDelivery(destination: params, title: title));
    } else if (view == 'started_delivery') {
      emit(StartedDelivery(title: params));
    } else if (view == 'end_delivery') {
      emit(EndDelivery());
    }
  }

  void acceptDelivery({required String id}) async {
    emit(AcceptDeliveryLoading());

    repository.acceptDelivery(id).then(
      (res) {
        res.fold(
          (failure) => emit(AcceptDeliveryFail(error: failure)),
          (success) {
            repository.acceptedDelivery = success;
            emit(AcceptDeliverySuccess(success));
          },
        );
      },
    );
  }
}
