class Stock {
  final String symbol;
  final String name;

  Stock({required this.symbol, required this.name});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['1. symbol'],
      name: json['2. name'],
    );
  }
}

class StockDetails {
  final String symbol;
  final double price;
  final double change;
  final double changePercent;

  StockDetails({
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePercent,
  });

  factory StockDetails.fromJson(Map<String, dynamic> json) {
    return StockDetails(
      symbol: json['01. symbol'] as String,
      price: double.parse(json['05. price']),
      change: double.parse(json['09. change']),
      changePercent: double.parse(json['10. change percent'].replaceAll('%', '')),
    );
  }
}


class TempStock {
  final String symbol;
  final String companyName;
  final double currentPrice;
  final double changeAmount;
  final double changePercentage;
  TempStock({
      required this.symbol,
      required this.companyName,
      required this.currentPrice,
      required this.changeAmount,
      required this.changePercentage,
  });
}
