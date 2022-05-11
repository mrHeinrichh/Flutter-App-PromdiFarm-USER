import 'package:dartz/dartz.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/data/models/parcel/parcel.model.dart';

abstract class ParcelRepository {
  Future<Either<Failure, Response>> movingDelivery(Destination destination);
  Future<Either<Failure, Response>> arrivingDelivery(Destination destination);
  Future<Either<Failure, Response>> arrivedDelivery(Destination destination);
  Future<Either<Failure, AcceptDelivery>> finishPickup(
    Destination destination,
  );
  Future<Either<Failure, Response>> waitingDelivery(Destination destination);
  Future<Either<Failure, Response>> notDelivered(Destination destination);
  Future<Either<Failure, Response>> retryDelivery(Destination destination);
  Future<Either<Failure, Response>> pickupParcel(Parcel parcel);
  Future<Either<Failure, AcceptDelivery>> cancelPickup(List<Parcel> parcels);
  Future<Either<Failure, AcceptDelivery>> cancelDelivery(
    Destination destination,
  );
}
