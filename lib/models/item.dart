import 'package:flutter/foundation.dart';

class Item {
  final int id;
  final String description;
  final DateTime date;
  final double amount;
  final bool isDeposit;
  final int typeId;
  final int accountId;

  Item({
    @required this.id,
    @required this.description,
    @required this.date,
    @required this.amount,
    @required this.isDeposit,
    @required this.typeId,
    @required this.accountId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'description': description,
        'date': date.toIso8601String(),
        'amount': amount,
        'isDeposit': isDeposit ? 1 : 0,
        'typeId': typeId,
        'accountId': accountId,
      };

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      amount: map['amount'],
      isDeposit: map['isDeposit'] == 1 ? true : false,
      typeId: map['typeId'],
      accountId: map['accountId'],
    );
  }
}
