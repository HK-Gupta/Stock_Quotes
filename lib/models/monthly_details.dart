class MonthlyDetailedModel {
  MetaData metaData;
  Map<String, MonthlyAdjustedTimeSeries> monthlyAdjustedTimeSeries;

  MonthlyDetailedModel({
    required this.metaData,
    required this.monthlyAdjustedTimeSeries,
  });

  factory MonthlyDetailedModel.fromJson(Map<String, dynamic> json) {
    return MonthlyDetailedModel(
      metaData: MetaData.fromJson(json['Meta Data']),
      monthlyAdjustedTimeSeries: (json['Monthly Adjusted Time Series'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, MonthlyAdjustedTimeSeries.fromJson(value)),
      ),
    );
  }
}

class MetaData {
  String the1Information;
  String the2Symbol;
  DateTime the3LastRefreshed;
  String the4TimeZone;

  MetaData({
    required this.the1Information,
    required this.the2Symbol,
    required this.the3LastRefreshed,
    required this.the4TimeZone,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      the1Information: json['1. Information'],
      the2Symbol: json['2. Symbol'],
      the3LastRefreshed: DateTime.parse(json['3. Last Refreshed']),
      the4TimeZone: json['4. Time Zone'],
    );
  }
}

class MonthlyAdjustedTimeSeries {
  String the1Open;
  String the2High;
  String the3Low;
  String the4Close;
  String the5AdjustedClose;
  String the6Volume;
  String the7DividendAmount;

  MonthlyAdjustedTimeSeries({
    required this.the1Open,
    required this.the2High,
    required this.the3Low,
    required this.the4Close,
    required this.the5AdjustedClose,
    required this.the6Volume,
    required this.the7DividendAmount,
  });

  factory MonthlyAdjustedTimeSeries.fromJson(Map<String, dynamic> json) {
    return MonthlyAdjustedTimeSeries(
      the1Open: json['1. open'],
      the2High: json['2. high'],
      the3Low: json['3. low'],
      the4Close: json['4. close'],
      the5AdjustedClose: json['5. adjusted close'],
      the6Volume: json['6. volume'],
      the7DividendAmount: json['7. dividend amount'],
    );
  }
}
