import 'package:flutter/material.dart';

import '../index.dart';

class TypesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Types'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TypePage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Text('Types'),
        ));
  }
}
