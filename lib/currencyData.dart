class CurrencyData {
  String name;
  String shortName;
  String symbol;
  double price;

  CurrencyData({this.name, this.shortName, this.symbol, this.price});

  @override
  String toString() {
    return 'CurrencyData{name: $name, shortName: $shortName, symbol: $symbol, price: $price}';
  }
}

