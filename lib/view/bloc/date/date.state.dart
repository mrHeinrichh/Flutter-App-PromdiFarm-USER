part of 'date.cubit.dart';

@immutable
abstract class DateState {}

// Initial state
class DateInitial extends DateState {}

class GetDate extends DateState {
  final DateTime dateTime;
  GetDate(this.dateTime);
}
