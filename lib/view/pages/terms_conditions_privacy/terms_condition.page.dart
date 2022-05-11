part of 'page.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Terms and Conditions"),
        backgroundColor: DARK,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(ROUTE.TERMS_PRIVACY_BACK);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: const [
                    const Paragraph(TERMS_CONDITION_1),
                    const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Header2(GOOGLE_PLAY),
                    ),
                    const Paragraph(TERMS_CONDITION_2),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
