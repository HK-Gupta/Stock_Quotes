import 'dart:convert';

import '../../models/stocks.dart';
import 'package:http/http.dart' as http;

// class StockRepository {
//   // final String apiKey = 'ZIYISXFFHX4TP7TW';
//   final String apiKey = 'demo';
//
//   Future<List<Stock>> fetchStockSymbols(String keyword) async {
//     final response = await http.get(Uri.parse('https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$keyword&apikey=$apiKey'));
//     print(response.body);
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print("1" + data);
//       return (data['bestMatches'] as List).map((stock) => Stock.fromJson(stock)).toList();
//     } else {
//       throw Exception('Failed to fetch stock symbols');
//     }
//   }
//
//   Future<StockDetails> fetchStockDetails(String symbol) async {
//     symbol = 'IBM';
//     final response = await http.get(Uri.parse('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey'));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print("2" + data);
//       return StockDetails.fromJson(data['Global Quote']);
//     } else {
//       throw Exception('Failed to fetch stock details');
//     }
//   }
//
// }
class StockRepository {
  final String apiKey = 'demo';

  Future<List<Stock>> fetchStockSymbols(String keyword) async {
    final response = await http.get(Uri.parse('https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$keyword&apikey=$apiKey'));
    print('Response body for fetchStockSymbols: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['bestMatches'] != null) {
        print('Parsed data for fetchStockSymbols: $data');
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
    print('Response status code for fetchStockDetails: ${response.statusCode}');
    print('Response body for fetchStockDetails: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Global Quote'] != null) {
        print('Parsed data for fetchStockDetails: $data');
        return StockDetails.fromJson(data['Global Quote']);
      } else {
        throw Exception('No Global Quote found in response');
      }
    } else {
      throw Exception('Failed to fetch stock details');
    }
  }
}