import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';

import '../../database/db_provider.dart';
import '../index.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: FutureBuilder(
        future: dbProvider.getAllItems(),
        builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('出错了'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var items = snapshot.data;

          if (items.length == 0) {
            return Center(child: Text('空空如也'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext _, int index) {
              Item item = items[index];

              var formatter = NumberFormat('#,##0.00', 'en_US');
              return ListTile(
                leading: Text(item.description),
                trailing: Text(formatter.format(item.amount)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ItemPage(
                                item: item,
                              )));
                },
              );
            },
          );
        },
      ),
    );
  }
}
