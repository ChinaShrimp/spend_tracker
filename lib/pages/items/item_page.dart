import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Map<String, dynamic> _data = Map<String, dynamic>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isDeposit = false;
  DateTime _date = DateTime.now();

  String get pageTitle {
    if (_isDeposit) {
      return '收入';
    } else {
      return '支出';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
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
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '描述',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) return '必填项';

                    return null;
                  },
                  onSaved: (String value) => _data['description'] = value,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: '金额',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) return '必填项';
                    if (double.tryParse(value) == null) return '不合法的数字';

                    return null;
                  },
                  onSaved: (String value) {
                    _data['amount'] = double.parse(value);
                  },
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isDeposit,
                      onChanged: (bool value) {
                        setState(() => _isDeposit = value);
                      },
                    ),
                    Text('存款'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: _date.add(Duration(days: -365)),
                          lastDate: _date.add(Duration(days: 365)),
                        );

                        setState(() {
                          if (date == null) return;

                          _date = date;
                        });
                      },
                    ),
                    Text(DateFormat('MM/dd/yyyy').format(_date)),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
