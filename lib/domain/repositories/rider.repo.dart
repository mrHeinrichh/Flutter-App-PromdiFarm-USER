import 'package:dartz/dartz.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';

abstract class RiderRepository {
  Future<Either<Failure, Response>> loginUser({
    String cred: "",
    String pass: "",
  });

  Future<Either<Failure, Response>> logoutUser();
  Future<Either<Failure, User>> getUserDetails();
}
