import 'package:flutter/material.dart';

import 'custom_divider.dart';

class DetailedContainer extends StatelessWidget {
  final double currentPrice;
  final String highestPrice;
  final String lowestPrice;
  const DetailedContainer({super.key, required this.currentPrice, required this.highestPrice, required this.lowestPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Current Price: "),
              Text(currentPrice.toString())
            ],
          ),
          const SizedBox(height: 2,),
          CustomDivider(),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Highest Price: "),
              Text(highestPrice)
            ],
          ),
          const SizedBox(height: 2,),
          CustomDivider(),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Low Price: "),
              Text(lowestPrice)
            ],
          ),
          const SizedBox(height: 2,),
          CustomDivider(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
