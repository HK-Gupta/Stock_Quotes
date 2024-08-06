import 'package:flutter/material.dart';

import '../models/stocks.dart';
class CustomCardView extends StatelessWidget {
  const CustomCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TempStock> stocks = [TempStock(
      symbol: 'AAPL',
      companyName: 'Apple Inc.',
      currentPrice: 150.25,
      changeAmount: 1.75,
      changePercentage: 1.18,
    )];
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10)
            ),
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                  ),
                ),
                const SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Symbol",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      "Name",
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${stocks[0].currentPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      '(${stocks[0].changePercentage >= 0 ? '+' : ''}${stocks[0].changePercentage.toStringAsFixed(2)}%)',
                      style: TextStyle(
                        fontSize: 15,
                        color: stocks[0].changePercentage >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
