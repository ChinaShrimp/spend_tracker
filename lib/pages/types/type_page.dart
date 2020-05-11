import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spend_tracker/utils/icon_helper.dart';
import '../../database/db_provider.dart';

import '../../models/item_type.dart';
import '../icons/icon_holder_widget.dart';

class TypePage extends StatefulWidget {
  ItemType type;

  TypePage({this.type});

  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  Map<String, dynamic> _data;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.type != null) {
      _data = widget.type.toMap();
    } else {
      _data = Map<String, dynamic>();

      _data['codePoint'] = Icons.add.codePoint;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Typ'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;

                _formKey.currentState.save();

                ItemType type = ItemType.fromMap(_data);
                if (widget.type == null) {
                  // create
                  dbProvider.createItemType(type);
                } else {
                  // update
                  dbProvider.updateItemType(type);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              IconHolderWidget(
                newIcon:
                    IconHelper.getIconDataFromCodePoint(_data['codePoint']),
                onIconChange: (IconData iconData) {
                  setState(() {
                    _data['codePoint'] = iconData.codePoint;
                  });
                },
              ),
              Form(
                  key: _formKey,
                  child: Wrap(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _data['name'],
                        decoration: InputDecoration(labelText: '名称'),
                        validator: (String value) {
                          if (value.isEmpty) return '必填项';

                          return null;
                        },
                        onSaved: (String value) {
                          _data['name'] = value;
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
