import 'package:dartz/dartz.dart';

abstract class Failure extends Error {
  final String message;
  Failure({required this.message});
}

class BasicFailure extends Failure {
  BasicFailure(String message) : super(message: message);
}

class RequestFailure extends Failure {
  RequestFailure(String message) : super(message: "Request failed: $message");
}

class ValidationFailure extends Failure {
  ValidationFailure(String message)
      : super(message: "Validation error: $message");
}

class NetworkFailure extends Failure {
  NetworkFailure(String message)
      : super(message: "Sorry can't display $message. You may be offline.");
}

class ErrorHandler {
  static Future<Either<Failure, T>> async<T>(
    Future<T> source,
  ) async {
    try {
      final sourceValue = await source;
      return Right(sourceValue);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  static Either<Failure, T> sync<T>(
    T source,
  ) {
    try {
      return Right(source);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  static String message(Failure failure) {
    switch (failure.runtimeType) {
      case ValidationFailure:
      case NetworkFailure:
      case RequestFailure:
        return failure.message;
      default:
        return 'Unexpected error';
    }
  }
}
