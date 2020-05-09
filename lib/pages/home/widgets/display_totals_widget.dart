import 'package:flutter/material.dart';

class DisplayTotalsWidget extends StatelessWidget {
  final String amount;

  const DisplayTotalsWidget({Key key, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green,
        gradient: LinearGradient(
          colors: [
            Colors.green,
            Colors.greenAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      child: Text(
        '\$$amount',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
