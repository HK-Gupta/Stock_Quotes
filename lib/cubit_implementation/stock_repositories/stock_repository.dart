import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/monthly_details.dart';
import '../../models/stocks.dart';
import 'package:http/http.dart' as http;

class StockRepository {
  final String apiKey = 'demo';

  Future<List<Stock>> fetchStockSymbols(String keyword) async {
    final response = await http.get(Uri.parse('https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$keyword&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['bestMatches'] != null) {
        return (data['bestMatches'] as List).map((stock) => Stock.fromJson(stock)).toList();
      } else {
        throw Exception('No bestMatches found in response');
      }
    } else {
      throw Exception('Failed to fetch stock symbols');
    }
  }

  Future<StockDetails> fetchStockDetails(String symbol) async {
    symbol = 'IBM';
    final response = await http.get(Uri.parse('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Global Quote'] != null) {

        return StockDetails.fromJson(data['Global Quote']);
      } else {
        throw Exception('No Global Quote found in response');
      }
    } else {
      throw Exception('Failed to fetch stock details');
    }
  }

  Future<MonthlyDetailedModel> fetchMonthlyDetails(String symbol) async {
    symbol = 'IBM';
    final response = await http.get(Uri.parse('https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=$symbol&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Meta Data'] != null && data['Monthly Adjusted Time Series'] != null) {

        final metaData = MetaData.fromJson(data['Meta Data']);
        final monthlyAdjustedTimeSeries = (data['Monthly Adjusted Time Series'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, MonthlyAdjustedTimeSeries.fromJson(value)));
        return MonthlyDetailedModel(
          metaData: metaData,
          monthlyAdjustedTimeSeries: monthlyAdjustedTimeSeries,
        );
      } else {
        throw Exception('Invalid response data');
      }
    } else {
      throw Exception('Failed to fetch monthly details');
    }
  }
}


