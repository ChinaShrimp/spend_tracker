import 'package:flutter/material.dart';
import 'package:spend_tracker/pages/home/widgets/main_menu_widget.dart';
import 'package:spend_tracker/pages/items/item_page.dart';

import 'widgets/bar_line_widget.dart';
import 'widgets/display_totals_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页')),
      drawer: MainMenuWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DisplayTotalsWidget(amount: '2400'),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            height: MediaQuery.of(context).size.height - 196,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BarLineWidget(
                  label: '取款',
                  color: Colors.red,
                  height: 50,
                  amount: 50,
                ),
                BarLineWidget(
                  label: '存款',
                  color: Colors.green,
                  height: 300,
                  amount: 500,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: PopupMenuButton(
          icon: Icon(
            Icons.add_circle,
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Text('存款'),
              ),
              PopupMenuItem(
                value: 0,
                child: Text('取款'),
              ),
            ];
          },
          onSelected: (int value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ItemPage(isDeposit: value, item: null),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
