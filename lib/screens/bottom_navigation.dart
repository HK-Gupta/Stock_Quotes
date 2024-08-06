import 'package:flutter/material.dart';
import 'package:stock_quote_app/screens/pages/home_page.dart';
import 'package:stock_quote_app/screens/pages/portfolio_page.dart';
import 'package:stock_quote_app/screens/pages/watchlist_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:stock_quote_app/widgets/custom_app_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  late List<Widget> pages;
  late HomePage homePage;
  late WatchlistPage watchlistPage;
  late PortfolioPage portfolioPage;
  int currentTabIndex= 0;

  @override
  void initState() {
    homePage = const HomePage();
    watchlistPage = const WatchlistPage();
    portfolioPage = const PortfolioPage();
    pages = [homePage, watchlistPage, portfolioPage];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).colorScheme.background,
        animationDuration: Duration(milliseconds: 700),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.home_rounded, color: Colors.white,),
          Icon(Icons.remove_red_eye, color: Colors.white,),
          Icon(Icons.shopify_outlined, color: Colors.white,),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
