import 'package:beatfusion/common/theme.dart';
import 'package:flutter/material.dart';

class FontStyles{
  static TextStyle greeting = TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().tertiaryColor,
    fontSize: 24,
    fontWeight: FontWeight.w700
  );

  static TextStyle button = TextStyle(
    fontFamily: 'Nunito',
    // color: MyTheme().tertiaryColor,
    fontSize: 20,
    fontWeight: FontWeight.w600
  );

  static TextStyle name = TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().tertiaryColor,
    fontSize: 15,
    fontWeight: FontWeight.w500
  );

  static TextStyle selectedName = TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().selectedTile,
    fontSize: 15,
    fontWeight: FontWeight.w500
  );

  static TextStyle artist = TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().tertiaryColor,
    fontSize: 12,
    fontWeight: FontWeight.w400
  );

  static TextStyle SelectedArtist = TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().selectedTile,
    fontSize: 12,
    fontWeight: FontWeight.w400
  );

  static TextStyle artist2 = TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().tertiaryColor,
    fontSize: 15,
    fontWeight: FontWeight.w400
  );

  static TextStyle name2 = TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().tertiaryColor,
    fontSize: 24,
    fontWeight: FontWeight.w600
  );

  static TextStyle tile = TextStyle(
    fontFamily: 'Nunito',
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w600
  );

  static TextStyle text = TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w100
  );

  static TextStyle order= TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().tertiaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w500
  );

  static TextStyle landing= TextStyle(
    fontFamily: 'Nunito',
    color: MyTheme().tertiaryColor,
    fontSize: 32,
    // height: 117/32,
    fontWeight: FontWeight.w600
  );

  static TextStyle settings= TextStyle(
    fontFamily: 'Nunito',
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500
  );

  static TextStyle settingsSub= TextStyle(
    fontFamily: 'Nunito',
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w100
  );
}