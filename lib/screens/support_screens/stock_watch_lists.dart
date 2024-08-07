import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_quote_app/cubit_implementation/stock_cubit.dart';
import 'package:stock_quote_app/cubit_implementation/stock_state.dart';
import 'package:stock_quote_app/models/stocks.dart';
import 'package:stock_quote_app/screens/pages/details_page.dart';

class StockWatchLists extends StatefulWidget {
  const StockWatchLists({super.key});

  @override
  State<StockWatchLists> createState() => _StockWatchListsState();
}

class _StockWatchListsState extends State<StockWatchLists> {
  late final StockCubit _stockCubit;
  List<String> _symbols = [];

  @override
  void initState() {
    super.initState();
    _stockCubit = context.read<StockCubit>();
    _fetchSymbols();
  }

  Future<void> _fetchSymbols() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final watchlistsSnapshot = await FirebaseFirestore.instance
          .collection('watchlists')
          .doc(user.uid)
          .get();

      if (watchlistsSnapshot.exists) {
        setState(() {
          _symbols = List<String>.from(watchlistsSnapshot.data()?['symbols'] ?? []);
          print("Symbols: $_symbols");
          _stockCubit.fetchStockDetailsForSymbols(_symbols);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width; // Get the width of the screen

    return BlocBuilder<StockCubit, StockState>(
        builder: (context, state) {
          if (state is StockLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is StockLoaded) {
            final stocks = state.stocks;
            final stockDetailsList = state.stockDetails;

            final filteredStocks = stocks.where((stock) => _symbols.contains(stock.symbol)).toList();
            final filteredStockDetails = stockDetailsList.where((details) => _symbols.contains(details.symbol)).toList();

            return Expanded(
              child: ListView.builder(
                itemCount: filteredStocks.length,
                itemBuilder: (context, index) {
                  final stock = filteredStocks[index];
                  final stockDetails = filteredStockDetails.firstWhere(
                        (details) => details.symbol == stock.symbol,
                    orElse: () => StockDetails(symbol: '', price: 0, change: 0, changePercent: 0, high: 0, open: 0, low: 0, volume: 0),
                  );
                  print("Length: ${filteredStocks.length}");
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsPage(
                        symbol: stock.symbol,
                        name: stock.name,
                        currentPrice: stockDetails.price,
                        highestPrice: stockDetails.high.toString(),
                        lowestPrice: stockDetails.low.toString(),
                        change: stockDetails.changePercent,
                      )));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            margin: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                              color: Colors.indigo,
                            ),
                            child: CircleAvatar(
                              child: Text(
                                stock.symbol[0],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                stock.symbol,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(
                                width: w / 2.5,
                                child: Text(
                                  stock.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${stockDetails.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: stockDetails.change >= 0 ? Colors.green : Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${stockDetails.change >= 0 ? '+' : ''}${stockDetails.change.toStringAsFixed(2)} (${stockDetails.changePercent >= 0 ? '+' : ''}${stockDetails.changePercent.toStringAsFixed(2)}%)',
                                style: TextStyle(
                                  color: stockDetails.change >= 0 ? Colors.green : Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is StockError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
  }
}
