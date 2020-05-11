import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spend_tracker/models/item_type.dart';

import '../../database/db_provider.dart';
import '../index.dart';

class TypesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context);

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
        body: FutureBuilder(
          future: dbProvider.getAllItemTypes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ItemType>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('出错了'),
              );
            }

            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final types = snapshot.data;

            if (types.length == 0) {
              return Center(
                child: Text('空空如也'),
              );
            }

            return ListView.builder(
              itemCount: types.length,
              itemBuilder: (BuildContext context, int index) {
                ItemType type = types[index];

                return ListTile(
                    leading: Icon(type.iconData),
                    title: Text(type.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TypePage(type: type)),
                      );
                    });
              },
            );
          },
        ));
  }
}
