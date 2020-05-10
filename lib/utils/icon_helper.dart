import 'package:flutter/material.dart';

class IconHelper {
  static IconData getIconDataFromCodePoint(int codePoint) {
    return IconData(codePoint, fontFamily: 'MaterialIcons');
  }
}
