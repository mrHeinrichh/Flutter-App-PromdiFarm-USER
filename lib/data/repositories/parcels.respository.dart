import 'package:dartz/dartz.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/data/models/parcel/parcel.model.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
import 'package:promdifarm_app/domain/sources/index.dart';

class ParcelsRepositoryImp extends ParcelRepository {
  final DeliverySource source;

  ParcelsRepositoryImp(this.source);

  @override
  Future<Either<Failure, Response>> movingDelivery(Destination destination) {
    return ErrorHandler.async<Response>(
      source.updateParcelTracking(
        type: RIDER_MOVING,
        comment: 'Moving to ${destination.address}',
        destination: destination,
        to: destination.id,
      ),
    );
  }

  @override
  Future<Either<Failure, Response>> arrivedDelivery(destination) {
    return ErrorHandler.async<Response>(
      source.updateParcelTracking(
        destination: destination,
        type: RIDER_ARRIVED,
        comment: 'Rider arrived at ${destination.address}.',
      ),
    );
  }

  @override
  Future<Either<Failure, AcceptDelivery>> finishPickup(
    Destination destination,
  ) {
    return ErrorHandler.async<AcceptDelivery>(
      source.finishPickup(destination),
    );
  }

  @override
  Future<Either<Failure, Response>> arrivingDelivery(destination) {
    // TODO: implement arrivingDelivery
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AcceptDelivery>> cancelDelivery(destination) {
    return ErrorHandler.async<AcceptDelivery>(
      source.addFailedDelivery(destination),
    );
  }

  @override
  Future<Either<Failure, Response>> notDelivered(destination) {
    // TODO: implement notDelivered
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Response>> retryDelivery(destination) {
    // TODO: implement retryDelivery
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Response>> waitingDelivery(destination) {
    // TODO: implement waitingDelivery
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Response>> pickupParcel(Parcel parcel) {
    return ErrorHandler.async<Response>(source.pickupParcel(parcel));
  }

  @override
  Future<Either<Failure, AcceptDelivery>> cancelPickup(List<Parcel> parcels) {
    return ErrorHandler.async<AcceptDelivery>(source.cancelPickup(parcels));
  }
}
