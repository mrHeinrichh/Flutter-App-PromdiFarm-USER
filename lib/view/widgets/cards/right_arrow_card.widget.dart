part of 'package:promdifarm_app/view/widgets/card.dart';

class RightArrowCard extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final void Function() onTap;

  const RightArrowCard({
    required this.title,
    required this.onTap,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        child: Card(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
