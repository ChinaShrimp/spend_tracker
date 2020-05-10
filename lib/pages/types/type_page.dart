import 'package:flutter/material.dart';
import 'package:spend_tracker/pages/icons/icon_holder_widget.dart';

class TypePage extends StatefulWidget {
  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  IconData _newIcon;
  Map<String, dynamic> _data = Map<String, dynamic>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Typ'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;

                _formKey.currentState.save();
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
                newIcon: _newIcon,
                onIconChange: (IconData iconData) {
                  setState(() {
                    _newIcon = iconData;
                  });
                },
              ),
              Form(
                  key: _formKey,
                  child: Wrap(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: '名称'),
                        validator: (String value) {
                          if (value.isEmpty) return '必填项';
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
