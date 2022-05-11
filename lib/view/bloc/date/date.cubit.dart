import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'date.state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateInitial());

  void openDateTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }

    emit(GetDate(selectedDate));
  }
}
