import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../database/db_provider.dart';
import '../../models/account.dart';
import '../../models/item.dart';
import '../../models/item_type.dart';

class ItemPage extends StatefulWidget {
  Item item;
  int isDeposit;

  ItemPage({this.isDeposit, this.item});
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Map<String, dynamic> _data = Map<String, dynamic>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Account> accounts = [];
  List<ItemType> itemTypes = [];

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      _data = widget.item.toMap();
    } else {
      _data = Map<String, dynamic>();
      if (widget.isDeposit != null) {
        _data['isDeposit'] = widget.isDeposit;
      } else {
        _data['isDeposit'] = false;
      }
      _data['date'] = DateTime.now().toIso8601String();
    }
  }

  String get pageTitle {
    if (_data['isDeposit'] == 1) {
      return '收入';
    } else {
      return '支出';
    }
  }

  void _loadAccountsAndItemTypes() async {
    if (!mounted) return;

    final dbProvider = Provider.of<DbProvider>(context);

    final a = await dbProvider.getAllAccounts();
    final t = await dbProvider.getAllItemTypes();

    setState(() {
      accounts = a;
      itemTypes = t;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _loadAccountsAndItemTypes();
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (!_formKey.currentState.validate()) return;

              _formKey.currentState.save();
              dbProvider.createItem(Item.fromMap(_data));
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
                  initialValue: _data['description'],
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
                  initialValue:
                      _data['amount'] != null ? _data['amount'].toString() : '',
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
                    items: itemTypes.isNotEmpty
                        ? itemTypes
                            .map((itemType) => DropdownMenuItem(
                                  value: itemType.id,
                                  child: Text(itemType.name),
                                ))
                            .toList()
                        : [],
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
                  items: accounts.isNotEmpty
                      ? accounts
                          .map((account) => DropdownMenuItem(
                                value: account.id,
                                child: Text(account.name),
                              ))
                          .toList()
                      : [],
                  onChanged: (int accountId) {
                    setState(() {
                      _data['accountId'] = accountId;
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _data['isDeposit'] == 1,
                      onChanged: (bool value) {
                        var intValue = value ? 1 : 0;
                        setState(() => _data['isDeposit'] = intValue);
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
                        var dateTime = DateTime.parse(_data['date']);

                        var date = await showDatePicker(
                          context: context,
                          initialDate: dateTime,
                          firstDate: dateTime.add(Duration(days: -365)),
                          lastDate: dateTime.add(Duration(days: 365)),
                        );

                        setState(() {
                          if (date == null) return;

                          _data['date'] = date.toIso8601String();
                        });
                      },
                    ),
                    Text(DateFormat('MM/dd/yyyy')
                        .format(DateTime.parse(_data['date']))),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
