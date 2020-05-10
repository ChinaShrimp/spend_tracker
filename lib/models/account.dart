import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/icon_helper.dart';

class Account {
  final int id;
  final String name;
  final int codePoint;
  final double balance;

  Account({
    @required this.id,
    @required this.name,
    @required this.codePoint,
    @required this.balance,
  });

  IconData get iconData {
    if (codePoint == null) return null;

    return IconHelper.getIconDataFromCodePoint(codePoint);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'codePoint': codePoint,
        'balance': balance,
      };

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      codePoint: map['codePoint'],
      balance: map['balance'],
    );
  }
}
