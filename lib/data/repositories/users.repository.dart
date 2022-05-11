import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
import 'package:promdifarm_app/domain/sources/index.dart';

class UsersRepositoryImp extends UsersRepository {
  final UserSource source;

  UsersRepositoryImp({
    required this.source,
  });

  @override
  Future<Either<Failure, Response>> login({cred: "", pass: ""}) async {
    return ErrorHandler.async<Response>(
      source.loginUser(cred: cred, pass: pass),
    );
  }

  @override
  Future<Either<Failure, Response>> logout() async {
    return ErrorHandler.async<Response>(source.logout());
  }

  @override
  Future<Either<Failure, User>> getUserDetails() {
    return ErrorHandler.async<User>(source.getUserDetails());
  }

  @override
  Future<Either<Failure, User>> uploadAvatar(File file) {
    return ErrorHandler.async<User>(source.uploadAvatar(file));
  }

  @override
  Future<Either<Failure, Response>> updateProfile(
      {firstName: "", lastName: "", birthDate: "", email: ""}) async {
    return ErrorHandler.async<Response>(
      source.updateProfile(
          firstName: firstName,
          lastName: lastName,
          birthDate: birthDate,
          email: email),
    );
  }
}
