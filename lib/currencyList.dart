import 'dart:core';
import 'package:flutter/material.dart';
import 'package:currency_app/currencyData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CurrencyListState();
  }
}

class CurrencyListState extends State<CurrencyList> {
  List<CurrencyData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Currency API'),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text("Currency Base: " + "EUR"),
        ),
        Expanded(
          child: ListView(
            children: _buildList(),
          ),
        ),
        Container (
          child: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () => _loadCurrency(),
          )
        ),

      ],
    )
    );
  }

  _loadCurrency() async {
    var currencyDataList = List<CurrencyData>();
    final response = await http.get('https://api.vatcomply.com/currencies');
    if (response.statusCode == 200){
      var allData = (json.decode(response.body) as Map);
      allData.forEach((jsonShortName, jsonName){
        var record = CurrencyData(
            name: jsonName['name'].toString(),
            shortName: jsonShortName,
            price: 1,
            symbol: jsonName['symbol'].toString(),
        );
        currencyDataList.add(record);
      });

    }
    final response2 = await http.get('https://api.vatcomply.com/rates');
    if (response2.statusCode == 200){
      var allData = (json.decode(response2.body) ['rates']);
      CurrencyData findElement(String name) => currencyDataList.firstWhere((currencyData) => currencyData.shortName == name);
      allData.forEach((val, price){
        var record = findElement(val.toString());
        if (record.shortName == "EUR") currencyDataList.remove(record);
        else record.price = price;
      });

      setState(() {
        data = currencyDataList;
      });

    }
  }

  List<Widget> _buildList() {
    return data.map((CurrencyData f) => ListTile(
      title: Text(f.name),
      subtitle: Text(f.shortName),
      leading: CircleAvatar (child: Text(f.symbol)),
      trailing: Text('${f.price.toStringAsFixed(2)}'),
    )).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadCurrency();
  }

}
