import 'package:flutter/material.dart';

class Header1 extends Text {
  const Header1(String text)
      : super(
          text,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        );
}

class Header2 extends Text {
  const Header2(String text)
      : super(
          text,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        );
}

class Header3 extends Text {
  const Header3(String text)
      : super(
          text,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        );
}

class Paragraph extends Text {
  const Paragraph(String text)
      : super(
          text,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 12,
          ),
        );
}

class Bullet extends Text {
  const Bullet(String text)
      : super(
          text,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 12,
          ),
        );
}
