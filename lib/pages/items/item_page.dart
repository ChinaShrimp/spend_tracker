import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../database/db_provider.dart';
import '../../models/account.dart';
import '../../models/item_type.dart';

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
  List<Account> accounts;
  List<ItemType> itemTypes;

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
