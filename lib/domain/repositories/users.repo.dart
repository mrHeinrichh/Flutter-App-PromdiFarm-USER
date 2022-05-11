import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';

abstract class UsersRepository {
  Future<Either<Failure, Response>> login({
    String cred: "",
    String pass: "",
  });

  Future<Either<Failure, Response>> logout();
  Future<Either<Failure, User>> getUserDetails();
  Future<Either<Failure, User>> uploadAvatar(File file);
  Future<Either<Failure, Response>> updateProfile({
    String firstName,
    String lastName,
    String birthDate,
    String email,
  });
}
