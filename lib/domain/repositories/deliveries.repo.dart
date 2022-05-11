import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';

abstract class DeliveriesRepository {
  AcceptDelivery get acceptedDelivery;
  set acceptedDelivery(AcceptDelivery value);
  List<Delivery> get list;
  Future<Either<Failure, List<Delivery>>> listDeliveries();
  Future<Either<Failure, AcceptDelivery>> acceptDelivery(String id);
  Future<Either<Failure, bool>> launchMap();
  Future<Either<Failure, AcceptDelivery>> completeDelivery(
    Destination destination,
    File image,
  );
  Future<Either<Failure, Response>> updateDestinationStatus({
    required List<String> destinations,
    required String status,
  });
  Future<Either<Failure, List<Delivery>>> endDelivery();
  Future<Either<Failure, AcceptDelivery>> retryDelivery(
    Destination destination,
  );
  Future<Either<Failure, List>> getRiderDeliveries();
}
