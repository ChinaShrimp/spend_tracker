import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/db_provider.dart';
import '../../models/account.dart';
import '../../utils/icon_helper.dart';
import '../icons/icon_holder_widget.dart';

class AccountPage extends StatefulWidget {
  final Account account;

  const AccountPage({Key key, this.account}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Map<String, dynamic> _data;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.account != null) {
      _data = widget.account.toMap();
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
          title: Text('Account'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                if (!_formKey.currentState.validate()) return;

                _formKey.currentState.save();

                Account account = Account.fromMap(_data);
                if (widget.account == null) {
                  // new record
                  await dbProvider.createAccount(account);
                } else {
                  // update record
                  await dbProvider.updateAccount(account);
                }

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
                    newIcon:
                        IconHelper.getIconDataFromCodePoint(_data['codePoint']),
                    onIconChange: (IconData iconData) {
                      setState(() {
                        _data['codePoint'] = iconData.codePoint;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: _data['name'] != null ? _data['name'] : '',
                    decoration: InputDecoration(labelText: '姓名'),
                    validator: (String value) {
                      if (value.isEmpty) return '必填项';

                      return null;
                    },
                    onSaved: (String value) => _data['name'] = value,
                  ),
                  TextFormField(
                    initialValue: _data['balance'] != null
                        ? _data['balance'].toString()
                        : '',
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: '余额'),
                    validator: (String value) {
                      if (value.isEmpty) return '必填项';

                      if (double.tryParse(value) == null) return '不合法的数字';

                      return null;
                    },
                    onSaved: (String value) =>
                        _data['balance'] = double.parse(value),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
