import 'package:flutter/material.dart';
import 'package:stock_quote_app/widgets/custom_app_bar.dart';

import '../../widgets/custom_divider.dart';
import '../support_screens/stock_list_view.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, "Watchlist", "pic"),
      body: Column(
        children: [
          // Search Bar Widget
          const SizedBox(height: 20,),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10)
              ),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // initiateSearch(value.toUpperCase());
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search...",
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    prefixIcon: InkWell(
                      onTap: () {
                      },
                      child: const Icon(
                        // search? Icons.cancel:
                        Icons.search,
                        color: Colors.white,
                      ),
                    )
                ),
              )
          ),
          const SizedBox(height: 10,),
          const CustomDivider(),
          const SizedBox(height: 10,),
          const StockListView(),
        ],
      ),
    );
  }
}
