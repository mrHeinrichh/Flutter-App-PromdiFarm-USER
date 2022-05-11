part of 'button.cubit.dart';

@immutable
abstract class ButtonState {}

// Initial state
class ButtonInitial extends ButtonState {}

class ButtonActive extends ButtonState {}

class ButtonInActive extends ButtonState {}
