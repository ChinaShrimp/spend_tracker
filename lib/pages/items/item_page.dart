import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemPage extends StatefulWidget {
  final bool value;

  ItemPage({@required value}) : this.value = (value == 0) ? true : false;
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Map<String, dynamic> _data = Map<String, dynamic>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();

    _data['isDeposit'] = widget.value;
  }

  String get pageTitle {
    if (_data['isDeposit']) {
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
                DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      labelText: '类型',
                    ),
                    value: _data['typeId'],
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('租房'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('吃饭'),
                      ),
                    ],
                    onChanged: (int typeId) {
                      setState(() {
                        _data['typeId'] = typeId;
                      });
                    }),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: '账户',
                  ),
                  value: _data['accountId'],
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('信用卡'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('储蓄卡'),
                    ),
                  ],
                  onChanged: (int accountId) {
                    setState(() {
                      _data['accountId'] = accountId;
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _data['isDeposit'],
                      onChanged: (bool value) {
                        setState(() => _data['isDeposit'] = value);
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
