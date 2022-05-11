import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/domain/repositories/users.repo.dart';
part 'side_nav.state.dart';

class SideNavCubit extends Cubit<SideNavState> {
  final UsersRepository repository;

  SideNavCubit({
    required this.repository,
  }) : super(SideNavInitial());

  void getUserCredentials() async {
    repository.getUserDetails().then((res) {
      res.fold(
        (failure) => emit(SideNavFailed(failure)),
        (success) => emit(SideNavDone(
          firstName: success.firstName,
          lastName: success.lastName,
          avatar: success.avatar,
        )),
      );
    });
  }

  Future<void> logout() {
    return repository.logout().then((res) {
      res.fold(
        (failure) => emit(LogOutUserFailed(failure)),
        (success) => emit(LogOutUserSuccess()),
      );
    });
  }
}
