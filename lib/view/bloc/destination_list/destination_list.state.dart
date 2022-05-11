part of 'destination_list.cubit.dart';

@immutable
abstract class DestinationListState {}

// Initial state
class DestinationListInitial extends DestinationListState {}

class InitTabController extends DestinationListState {
  final TabController tabController;
  InitTabController(this.tabController);
}

class SwitchTab extends DestinationListState {
  final int index;
  SwitchTab(this.index);
}
