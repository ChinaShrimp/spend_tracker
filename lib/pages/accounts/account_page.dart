import 'package:flutter/material.dart';

import '../icons/icon_holder_widget.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Map<String, dynamic> _data = Map<String, dynamic>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IconData _newIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
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
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
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
                  TextFormField(
                    decoration: InputDecoration(labelText: '姓名'),
                    validator: (String value) {
                      if (value.isEmpty) return '必填项';

                      return null;
                    },
                    onSaved: (String value) => _data['name'] = value,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: '余额'),
                    validator: (String value) {
                      if (value.isEmpty) return '必填项';

                      if (double.tryParse(value) == null) return '不合法的数字';

                      return null;
                    },
                    onSaved: (String value) => _data['balance'] = value,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
