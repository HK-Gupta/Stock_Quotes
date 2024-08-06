import 'package:flutter/material.dart';
import 'package:stock_quote_app/config/assets_path.dart';

import '../../models/stocks.dart';

class MyStocksList extends StatelessWidget {
  const MyStocksList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TempStock> stocks = [
      TempStock(
        symbol: 'FLWR',
        companyName: 'Flower Tech Solutions',
        currentPrice: 105.80,
        changeAmount: 3.20,
        changePercentage: 3.12,
      ),
      TempStock(
        symbol: 'GRBL',
        companyName: 'Garble Electronics Corp.',
        currentPrice: 250.45,
        changeAmount: -10.50,
        changePercentage: -4.02,
      ),
      TempStock(
        symbol: 'CRYO',
        companyName: 'CryoHealth Inc.',
        currentPrice: 198.40,
        changeAmount: -7.80,
        changePercentage: -3.78,
      ),
      TempStock(
        symbol: 'PHNX',
        companyName: 'Phoenix Renewable Energy',
        currentPrice: 620.15,
        changeAmount: 12.45,
        changePercentage: 2.05,
      )
    ];

    return GridView.builder(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1.15
      ),
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      margin: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: Colors.indigo
                      ),
                      child: CircleAvatar(
                        child: Text(
                          stock.symbol[0],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  stock.symbol,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Text(
                      '\$${stock.currentPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 4,),
                    Text(
                      '(${stock.changePercentage >= 0 ? '+' : ''}${stock.changePercentage.toStringAsFixed(2)}%)',
                      style: TextStyle(
                        fontSize: 15,
                        color: stock.changePercentage >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
