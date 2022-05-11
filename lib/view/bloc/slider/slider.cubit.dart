import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'slider.state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  void online() {
    emit(SliderOnline());
  }

  void offline() {
    emit(SliderOffline());
  }

  void reset() {
    emit(SliderInitial());
  }
}
