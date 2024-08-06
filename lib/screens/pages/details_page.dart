import 'package:flutter/material.dart';
import 'package:stock_quote_app/widgets/custom_app_bar.dart';
import 'package:stock_quote_app/widgets/custom_button.dart';
import 'package:stock_quote_app/widgets/custom_cardview.dart';
import 'package:stock_quote_app/widgets/custom_divider.dart';
import 'package:stock_quote_app/widgets/detailed_container.dart';

class DetailsPage extends StatefulWidget {
  final String symbol;
  const DetailsPage({super.key, required this.symbol});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: CustomAppBar(context, "Details", ""),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CustomCardView(),
            Container(
              color: Colors.white,
              width: w/1.2,
              height: h/3,
            ),
            const SizedBox(height: 20,),
            const CustomDivider(),
            const DetailedContainer(),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(child: CustomButton(buttonText: "Buy", onTap: () {})),
                const SizedBox(width: 10),
                Expanded(child: CustomButton(
                  buttonText: "Add to Watchlist",
                  onTap: () {},
                  buttonColor: Colors.orange[400],
                  )
                ),
                const SizedBox(width: 10),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
