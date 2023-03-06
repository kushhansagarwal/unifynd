import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//default font is Quicksand
var kDefaultFont = GoogleFonts.quicksand();

//make the color pallete

// Primary colors
const Color kPrimaryColor = Color(0xFF8ED9D2);
const Color kDarkColor = Color(0xFF000000);

// Accent colors
const Color kAccentOneColor = Color(0xFFADC1F3);
const Color kAccentTwoColor = Color(0xFFF09FA0);
const Color kAccentThreeColor = Color(0xFF98DCE7);

//make logo text style with default font in size 20

var kLogoTextStyle = kDefaultFont.copyWith(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  fontFamily: kDefaultFont.fontFamily,
);

//make light text style with an optional size
var kLightTextStyle = kDefaultFont.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    fontFamily: kDefaultFont.fontFamily,
    color: Colors.white);

//make three text styles with color in white and names as kCardTitle, kCardByTitle, kCardSubtile

var kCardTitle = kDefaultFont.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    fontFamily: kDefaultFont.fontFamily,
    color: kDarkColor);

var kCardByTitle = kDefaultFont.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: kDefaultFont.fontFamily,
    color: kDarkColor.withAlpha(150));

var kCardSubtile = kDefaultFont.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w900,
    fontFamily: kDefaultFont.fontFamily,
    color: kDarkColor);

Widget Logo(double size) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: 'Uni',
            style: TextStyle(
                fontFamily: kDefaultFont.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: size,
                color: kDarkColor)),
        TextSpan(
            text: 'Fynd',
            style: TextStyle(
                fontFamily: kDefaultFont.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: size,
                color: kPrimaryColor)),
      ],
    ),
  );
}

Widget LogoWhite(double size) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: 'Uni',
            style: TextStyle(
                fontFamily: kDefaultFont.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: size,
                color: kDarkColor)),
        TextSpan(
            text: 'Fynd',
            style: TextStyle(
                fontFamily: kDefaultFont.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: size,
                color: Colors.white)),
      ],
    ),
  );
}

//make swatch color for the app

const MaterialColor kPrimarySwatch = MaterialColor(
  0xFF8ED9D2,
  <int, Color>{
    50: Color(0xFF8ED9D2),
    100: Color(0xFF8ED9D2),
    200: Color(0xFF8ED9D2),
    300: Color(0xFF8ED9D2),
    400: Color(0xFF8ED9D2),
    500: Color(0xFF8ED9D2),
    600: Color(0xFF8ED9D2),
    700: Color(0xFF8ED9D2),
    800: Color(0xFF8ED9D2),
    900: Color(0xFF8ED9D2),
  },
);
