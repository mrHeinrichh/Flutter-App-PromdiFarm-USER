part of 'slider.cubit.dart';

@immutable
abstract class SliderState {}

// Initial state
class SliderInitial extends SliderState {}

class SliderOnline extends SliderState {}

class SliderOffline extends SliderState {}
