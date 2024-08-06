import 'package:flutter/material.dart';

import 'custom_divider.dart';

class DetailedContainer extends StatelessWidget {
  const DetailedContainer({super.key});

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
              Text("₹ 100.65")
            ],
          ),
          const SizedBox(height: 2,),
          CustomDivider(),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Highest Price: "),
              Text("₹ 100.65")
            ],
          ),
          const SizedBox(height: 2,),
          CustomDivider(),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Low Price: "),
              Text("₹ 100.65")
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
