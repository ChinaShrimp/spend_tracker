import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spend Tracker',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
