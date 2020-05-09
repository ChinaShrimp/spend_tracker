import 'package:flutter/material.dart';

class MainMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Accounts'),
            onTap: () {
              Navigator.of(context).pushNamed('/accounts');
            },
          ),
          ListTile(
            title: Text('Budget Items'),
            onTap: () {
              Navigator.of(context).pushNamed('/items');
            },
          ),
          ListTile(
            title: Text('Types'),
            onTap: () {
              Navigator.of(context).pushNamed('/types');
            },
          ),
        ],
      ),
    );
  }
}
