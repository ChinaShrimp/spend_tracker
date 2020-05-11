import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../database/db_provider.dart';
import 'account_page.dart';

class AccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountPage(),
                  ));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: dbProvider.getAllAccounts(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('出错了!'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var accounts = snapshot.data;

          if (accounts.length == 0) {
            return Center(
              child: Text('没有记录'),
            );
          }

          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (_, int index) {
              var account = accounts[index];
              var formatter = NumberFormat('#,##0.00', 'en_US');

              return ListTile(
                  leading: Icon(account.iconData),
                  title: Text('${account.name}'),
                  trailing: Text('\$' + formatter.format(account.balance)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AccountPage(account: account),
                        ));
                  });
            },
          );
        },
      ),
    );
  }
}
