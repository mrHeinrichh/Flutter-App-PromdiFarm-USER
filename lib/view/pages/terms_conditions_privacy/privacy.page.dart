part of 'page.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NEUTRAL_PRIMARY_ACCENT,
      appBar: AppBar(
        title: Text("Privacy Policy"),
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
                  children: [
                    Paragraph(TITLE.PRIVACY_INTRODUCTION),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Header2(TITLE.GOOGLE_PLAY),
                    ),
                    Header3(TITLE.LOG_DATA),
                    Paragraph(TITLE.LOG_DATA_CONTENT),
                    Header3(TITLE.COOKIES),
                    Paragraph(TITLE.COOKIES_CONTENT),
                    Header3(TITLE.SERVICE_PROVIDERS),
                    Paragraph(TITLE.SERVICE_PROVIDERS_CONTENTS),
                    Bullet(TITLE.BULLET_TEXT),
                    Paragraph(TITLE.SERVICE_PROVIDERS_CONTENTS_2),
                    Header3(TITLE.SECURITY),
                    Paragraph(TITLE.SECURITY_CONTENTS),
                    Header3(TITLE.LINKS),
                    Paragraph(TITLE.LINKS_CONTENT),
                    Header3(TITLE.CHILD_PRIVACY),
                    Paragraph(TITLE.CHILD_PRIVACY_CONTENTS),
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
