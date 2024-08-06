import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_quote_app/screens/pages/details_page.dart';

import '../../cubit_implementation/stock_cubit.dart';
import '../../cubit_implementation/stock_state.dart';
import '../../models/stocks.dart';

class StockListView extends StatelessWidget {
  const StockListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the stock symbols and details on initialization
    context.read<StockCubit>().fetchStocks('tencent');
    final w = MediaQuery.of(context).size.width;
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is StockLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is StockLoaded) {
          final stocks = state.stocks;
          final stockDetailsList = state.stockDetails;

          return Expanded(
            child: ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];
                final stockDetails = stockDetailsList.firstWhere(
                      (details) => details.symbol == stock.symbol,
                  orElse: () => StockDetails(symbol: '', price: 0, change: 0, changePercent: 0),
                );

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsPage(symbol: stock.symbol,)));
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
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              stock.symbol,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(
                              width: w/2.5,
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
