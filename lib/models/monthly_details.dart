class MonthlyDetailedModel {
  MetaData metaData;
  Map<String, MonthlyAdjustedTimeSery> monthlyAdjustedTimeSeries;

  MonthlyDetailedModel({
    required this.metaData,
    required this.monthlyAdjustedTimeSeries,
  });

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

}

class MonthlyAdjustedTimeSery {
  String the1Open;
  String the2High;
  String the3Low;
  String the4Close;
  String the5AdjustedClose;
  String the6Volume;
  String the7DividendAmount;

  MonthlyAdjustedTimeSery({
    required this.the1Open,
    required this.the2High,
    required this.the3Low,
    required this.the4Close,
    required this.the5AdjustedClose,
    required this.the6Volume,
    required this.the7DividendAmount,
  });

}
