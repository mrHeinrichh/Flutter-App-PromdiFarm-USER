import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/core/const/strings.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/view/widgets/card.dart';
import 'package:promdifarm_app/view/widgets/text.widget.dart';
part 'privacy.page.dart';
part 'terms_condition.page.dart';

const EdgeInsets RightArrowCardPadding = const EdgeInsets.symmetric(
  horizontal: 10,
  vertical: 5,
);

class TermsConditionPrivacy extends StatelessWidget {
  const TermsConditionPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text(
          "More",
        ),
        backgroundColor: DARK,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(ROUTE.HOME_BACK);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ListView(
              children: [
                RightArrowCard(
                  onTap: () {
                    context.goNamed(ROUTE.TERMS_CONDITION);
                  },
                  title: "Terms and Condition",
                  padding: RightArrowCardPadding,
                ),
                RightArrowCard(
                  onTap: () {
                    context.goNamed(ROUTE.PRIVACY);
                  },
                  title: "Privacy Policy",
                  padding: RightArrowCardPadding,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
