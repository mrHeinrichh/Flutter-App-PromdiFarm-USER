import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';

class CheckBoxText extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?) onChanged;

  const CheckBoxText({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        children: [
          BlocProvider<ButtonCubit>(
            create: (BuildContext context) => sl<ButtonCubit>(),
            child: BlocBuilder<ButtonCubit, ButtonState>(
              builder: (context, state) {
                bool wasClicked = value;

                if (state is ButtonActive) wasClicked = true;
                if (state is ButtonInActive) wasClicked = false;

                return Checkbox(
                  value: wasClicked,
                  onChanged: (value) {
                    if (value != null && value == true) {
                      BlocProvider.of<ButtonCubit>(context).isClick();
                    } else {
                      BlocProvider.of<ButtonCubit>(context).isReset();
                    }

                    onChanged(value);
                  },
                  activeColor: DARK,
                );
              },
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: NEUTRAL_PRIMARY_DARK,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
