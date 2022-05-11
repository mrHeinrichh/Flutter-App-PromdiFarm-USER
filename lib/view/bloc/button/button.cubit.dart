import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'button.state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  void isClick() {
    emit(ButtonActive());
  }

  void isReset() {
    emit(ButtonInActive());
  }
}
