import 'package:bloc/bloc.dart';
import 'package:stock_quote_app/cubit_implementation/stock_repositories/stock_repository.dart';
import 'package:stock_quote_app/cubit_implementation/stock_state.dart';

import '../models/stocks.dart';

class StockCubit extends Cubit<StockState> {
  final StockRepository stockRepository;

  StockCubit(this.stockRepository) : super(StockInitial());

  Future<void> fetchStocks(String keyword) async {
    try {
      emit(StockLoading());
      final stocks = await stockRepository.fetchStockSymbols(keyword);
      final stockDetailsList = <StockDetails>[];
      for (final stock in stocks) {
        final details = await stockRepository.fetchStockDetails(stock.symbol);
        stockDetailsList.add(details);
      }

      emit(StockLoaded(stocks, stockDetailsList));
    } catch (e) {
      emit(StockError("Failed to fetch stock details"));
    }
  }

  Future<void> fetchMonthlyDetails(String symbol) async {
    try {
      emit(StockLoading());
      final monthlyDetails = await stockRepository.fetchMonthlyDetails(symbol);
      emit(MonthlyDetailsLoaded(monthlyDetails));
    } catch (e) {
      emit(StockError("Failed to fetch monthly details"));
    }
  }

  Future<void> fetchStockDetailsForSymbols(List<String> symbols) async {
    emit(StockLoading());

    try {
      final stockDetailsList = await Future.wait(
        symbols.map((symbol) async {
          final details = await stockRepository.fetchStockDetails(symbol);
          return details;
        }),
      );

      final stocks = await stockRepository.fetchStockSymbols(''); // Modify this to fetch stock symbols or adjust as needed
      emit(StockLoaded(stocks, stockDetailsList));
    } catch (e) {
      emit(StockError("Failed to fetch stock details for symbols: ${e.toString()}"));
    }
  }

}

