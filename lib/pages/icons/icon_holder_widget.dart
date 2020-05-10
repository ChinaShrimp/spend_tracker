import 'package:flutter/material.dart';

import '../index.dart';

typedef void OnIconChange(IconData iconData);

class IconHolderWidget extends StatelessWidget {
  final IconData newIcon;
  final OnIconChange onIconChange;

  IconHolderWidget({
    @required this.newIcon,
    @required this.onIconChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.blueGrey,
          ),
        ),
        child: InkWell(
          onTap: () async {
            var iconData = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IconsPage(),
              ),
            );

            onIconChange(iconData);
          },
          child: Icon(
            newIcon == null ? Icons.add : newIcon,
            size: 60,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
