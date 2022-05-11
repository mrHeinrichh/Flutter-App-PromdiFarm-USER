import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
part 'user.state.dart';

class UserCubit extends Cubit<UserState> {
  final UsersRepository repository;

  UserCubit({required this.repository}) : super(UserInitial());

  void loginUser({String cred = "", String pass = ""}) {
    emit(AuthUserLoading());

    if (cred.isEmpty || pass.isEmpty)
      emit(AuthUserEmpty(msg: "Fields are empty"));

    repository.login(cred: cred, pass: pass).then(
      (res) {
        res.fold(
          (failure) => emit(AuthUserFail(failure)),
          (success) => emit(AuthUserSuccess(msg: success.message)),
        );
      },
    );
  }
}
