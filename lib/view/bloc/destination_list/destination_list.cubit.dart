import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'destination_list.state.dart';

class DestinationListCubit extends Cubit<DestinationListState> {
  DestinationListCubit() : super(DestinationListInitial());
}
