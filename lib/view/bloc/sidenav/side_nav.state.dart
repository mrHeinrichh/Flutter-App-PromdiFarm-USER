part of 'side_nav.cubit.dart';

@immutable
abstract class SideNavState {}

// Initial state
class SideNavInitial extends SideNavState {}

class LogOutUserFailed extends SideNavState {
  final Failure error;
  LogOutUserFailed(this.error);
}

class LogOutUserSuccess extends SideNavState {}

class SideNavFailed extends SideNavState {
  final Failure error;
  SideNavFailed(this.error);
}

class SideNavDone extends SideNavState {
  final String firstName;
  final String lastName;
  final String avatar;

  SideNavDone({
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
}
