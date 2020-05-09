import 'package:flutter/material.dart';

class MainMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return SizedBox(
      width: 150,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              alignment: Alignment.bottomCenter,
              child: Text('菜单'),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            MenuItemWidget(
              name: '账户',
              icon: Icons.account_balance,
              size: 50,
              color: color,
              onTap: () => _onNavigation(context, '/accounts'),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            MenuItemWidget(
              name: '清单',
              icon: Icons.attach_money,
              size: 50,
              color: color,
              onTap: () => _onNavigation(context, '/items'),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            MenuItemWidget(
              name: '类型',
              icon: Icons.widgets,
              size: 50,
              color: color,
              onTap: () => _onNavigation(context, '/types'),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _onNavigation(BuildContext context, String uri) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(uri);
  }
}

class MenuItemWidget extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;
  final double size;
  final onTap;

  const MenuItemWidget({
    Key key,
    @required this.name,
    @required this.color,
    @required this.icon,
    @required this.size,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: 0.7,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: color,
                size: size,
              ),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
