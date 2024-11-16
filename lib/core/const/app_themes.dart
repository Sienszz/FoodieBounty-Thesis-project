import 'package:flutter/material.dart';

class AppThemes {
  static const darkBlue = Color(0xff2D5BA0);
  static const blue =  Color(0xff1E73C1);
  static const lightBlue = Color(0xff127BDC);
  static const red = Color(0xffF21212);
  static const green = Color(0xff177315);
  static const superLightBlue = Color(0xffE6F3FC);
  static const white = Colors.white;
  static const black = Colors.black;

  static const veryDarkBlue = Color(0xffF113D66);
  static const moreDarkBlue = Color(0xffF1D5F84);

  static const _level1 = Color(0xff8D4231);
  static const _level2 = Color(0xffE7974D);
  static const _level3 = Color(0xff70B857);
  static const _level4 = Color(0xff763CBF);
  static const _level5 = Color(0xff2D2D2D);

  static const levelColor = {
    1: _level1,
    2: _level2,
    3: _level3,
    4: _level4,
    5: _level5
  };

  double defaultFormHeight = 55.0; //default form text height
  double minSpacing = 4.0;
  double defaultSpacing = 8.0;
  double biggerSpacing = 12.0;
  double extraSpacing = 16.0;
  double veryExtraSpacing = 30.0;

  TextStyle text1({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 32,
    );
    return text;
  }

  TextStyle text2({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 24,
    );
    return text;
  }

  TextStyle text3({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 18,
    );
    return text;
  }

  TextStyle text4({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 16,
    );
    return text;
  }

  TextStyle text5({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 14,
    );
    return text;
  }

  TextStyle text6({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 12,
    );
    return text;
  }

  TextStyle text7({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 10,
    );
    return text;
  }

  TextStyle text1Bold({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 32,
      fontWeight: FontWeight.w700,
    );
    return text;
  }

  TextStyle text2Bold({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
    return text;
  }

  TextStyle text3Bold({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
    return text;
  }

  TextStyle text4Bold({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    return text;
  }

  TextStyle text5Bold({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
    return text;
  }

  TextStyle text6Bold({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );
    return text;
  }

}