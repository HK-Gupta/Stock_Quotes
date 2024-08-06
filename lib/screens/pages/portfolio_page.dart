import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stock_quote_app/config/assets_path.dart';
import 'package:stock_quote_app/screens/support_screens/my_stocks_list.dart';
import 'package:stock_quote_app/widgets/custom_app_bar.dart';
import 'package:stock_quote_app/widgets/custom_user_balance.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  Widget build(BuildContext context) {
    final w =  MediaQuery.of(context).size.width;
    final h =  MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(context, "Hello User", "abs"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset(
                LottiePath.homeLottie,
                fit: BoxFit.fill,
                height: h/4.5,
                width: w/1.25
            ),
            const CustomUserBalance(),
            const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Investments",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "See all",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.orange
                    ),
                  )
                ],
              ),
            ),
            const MyStocksList()
          ],
        ),
      ),
    );
  }
}
