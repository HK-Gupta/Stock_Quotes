import 'package:flutter/material.dart';

import '../models/stocks.dart';
class CustomCardView extends StatelessWidget {
  final String symbol;
  final String name;
  final double price;
  final double change;
  const CustomCardView({super.key, required this.symbol, required this.name, required this.price, required this.change});

  @override
  Widget build(BuildContext context) {
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
            width: MediaQuery.of(context).size.width,
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
                      symbol[0],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symbol,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2.5,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        name,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      '(${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%)',
                      style: TextStyle(
                        fontSize: 15,
                        color: change >= 0 ? Colors.green : Colors.red,
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
