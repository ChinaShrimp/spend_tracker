import 'package:flutter/material.dart';

import 'icons_list.dart';

class IconsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(title: Text('Icons')),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: icons
                    .map(
                      (iconData) => Opacity(
                        opacity: 0.7,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop(iconData);
                          },
                          child: Icon(
                            iconData,
                            size: 60,
                            color: color,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ));
  }
}
