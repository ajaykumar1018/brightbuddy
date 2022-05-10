import 'package:flutter/material.dart';

class MyTextStyle {
  static TextStyle mulish() {
    // return GoogleFonts.mulish();
    return TextStyle(fontFamily: "SFPro");
  }

  static TextStyle sFPro() {
    return TextStyle(fontFamily: "SFPro");
  }

  static TextStyle mulishBlack() {
    return TextStyle(fontFamily: "MulishBlack");
  }

  static TextStyle babib() {
    return TextStyle(fontFamily: "babib");
  }
}

const kTextFieldDecoration = InputDecoration(
  filled: true,
  counterText: "",
  hintText: 'Enter the respective value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
