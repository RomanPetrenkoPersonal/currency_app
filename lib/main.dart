import 'package:currency_app/currencyList.dart';
import 'package:flutter/material.dart';

void main() => runApp(CurrencyApp());

class CurrencyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Currency APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CurrencyList()
    );
  }
}
