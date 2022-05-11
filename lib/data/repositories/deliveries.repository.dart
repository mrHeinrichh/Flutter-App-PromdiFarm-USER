import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
import 'package:promdifarm_app/domain/sources/deliveries.src.dart';

class DeliveriesRepositoryImp extends DeliveriesRepository {
  final DeliverySource source;

  DeliveriesRepositoryImp(this.source);

  List<Delivery> get list => source.getDeliveries();

  AcceptDelivery get acceptedDelivery => source.getAcceptedDelivery();

  set acceptedDelivery(AcceptDelivery value) {
    source.setAcceptedDelivery(value);
  }

  @override
  acceptDelivery(String id) {
    return ErrorHandler.async<AcceptDelivery>(
      source.acceptDelivery(id),
    );
  }

  @override
  listDeliveries() {
    return ErrorHandler.async<List<Delivery>>(
      source.fetchAvailableDeliveries(),
    );
  }

  @override
  Future<Either<Failure, bool>> launchMap() {
    return ErrorHandler.async<bool>(
      source.launchMap(),
    );
  }

  @override
  Future<Either<Failure, AcceptDelivery>> completeDelivery(
    Destination destination,
    File image,
  ) {
    return ErrorHandler.async<AcceptDelivery>(
      source.addCompletedDelivery(destination, image),
    );
  }

  @override
  Future<Either<Failure, AcceptDelivery>> retryDelivery(
    Destination destination,
  ) {
    return ErrorHandler.async<AcceptDelivery>(
      source.retryDelivery(destination),
    );
  }

  @override
  Future<Either<Failure, Response>> updateDestinationStatus({
    required List<String> destinations,
    required String status,
  }) {
    return ErrorHandler.async<Response>(
      source.updateDestinationStatus(
        destinations: destinations,
        status: status,
        id: acceptedDelivery.id,
      ),
    );
  }

  @override
  Future<Either<Failure, List<Delivery>>> endDelivery() {
    return ErrorHandler.async<List<Delivery>>(
      source.endDelivery(acceptedDelivery.id),
    );
  }

  @override
  Future<Either<Failure, List>> getRiderDeliveries() {
    return ErrorHandler.async<List>(
      source.getRiderDeliveries(),
    );
  }
}
