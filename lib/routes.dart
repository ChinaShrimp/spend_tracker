import 'package:flutter/material.dart';
import 'pages/index.dart';

final routes = {
  '/': (BuildContext context) => HomePage(),
  '/accounts': (BuildContext context) => AccountsPage(),
  '/items': (BuildContext context) => ItemsPage(),
  '/icons': (BuildContext context) => IconsPage(),
  '/types': (BuildContext context) => TypesPage(),
};
