import 'package:flutter/material.dart';

class BarLineWidget extends StatelessWidget {
  final String label;
  final double height;
  final Color color;
  final double amount;

  const BarLineWidget({
    Key key,
    @required this.label,
    @required this.color,
    @required this.height,
    @required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: height,
          width: 100,
          color: color,
        ),
        Text(label),
        Text(amount.toString()),
      ],
    );
  }
}
