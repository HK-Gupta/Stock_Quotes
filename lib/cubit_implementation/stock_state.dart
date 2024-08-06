import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../models/monthly_details.dart';
import '../models/stocks.dart';


@immutable
abstract class StockState extends Equatable {
  @override
  List<Object> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<Stock> stocks;
  final List<StockDetails> stockDetails;

  StockLoaded(this.stocks, this.stockDetails);

  @override
  List<Object> get props => [stocks, stockDetails];
}

class StockError extends StockState {
  final String message;

  StockError(this.message);

  @override
  List<Object> get props => [message];
}

class MonthlyDetailsLoaded extends StockState {
  final MonthlyDetailedModel monthlyDetails;

  MonthlyDetailsLoaded(this.monthlyDetails);

  @override
  List<Object> get props => [monthlyDetails];
}
