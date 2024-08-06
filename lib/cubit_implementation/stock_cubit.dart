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
      print(stocks);
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
}

