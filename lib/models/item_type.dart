import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/icon_helper.dart';

class ItemType {
  final int id;
  final String name;
  final int codePoint;

  ItemType({
    @required this.id,
    @required this.name,
    @required this.codePoint,
  });

  IconData get iconData {
    return IconHelper.getIconDataFromCodePoint(codePoint);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'codePoint': codePoint,
      };

  factory ItemType.fromMap(Map<String, dynamic> map) {
    return ItemType(
      id: map['id'],
      codePoint: map['codePoint'],
      name: map['name'],
    );
  }
}
