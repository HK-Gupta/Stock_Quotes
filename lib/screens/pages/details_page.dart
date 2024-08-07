import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_quote_app/widgets/custom_app_bar.dart';
import 'package:stock_quote_app/widgets/custom_button.dart';
import 'package:stock_quote_app/widgets/custom_cardview.dart';
import 'package:stock_quote_app/widgets/custom_divider.dart';
import 'package:stock_quote_app/widgets/detailed_container.dart';
import 'package:stock_quote_app/widgets/snackbar_message.dart';

import '../../cubit_implementation/stock_cubit.dart';
import '../../cubit_implementation/stock_state.dart';


class DetailsPage extends StatefulWidget {
  final String symbol;
  final String name;
  final double currentPrice;
  final String highestPrice;
  final String lowestPrice;
  final double change;
  const DetailsPage({super.key, required this.symbol, required this.currentPrice, required this.highestPrice, required this.lowestPrice, required this.name, required this.change});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isAdding = false;
  @override
  void initState() {
    super.initState();
    context.read<StockCubit>().fetchMonthlyDetails(widget.symbol);
  }

  void _addToWatchlist() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      isAdding = true;
      setState(() {});
      final watchlistRef = FirebaseFirestore.instance
          .collection('watchlists')
          .doc(user.uid);
      await watchlistRef.set({
        'symbols': FieldValue.arrayUnion([widget.symbol])
      }, SetOptions(merge: true));

      SnackbarMessage.showSuccessSnackBar(context, 'Successfully Added to Watchlist');
    } else {
      SnackbarMessage.showErrorSnackBar(context, 'Failed to add');
    }
    isAdding = false;
    setState(() {});
  }


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
            CustomCardView(
              symbol: widget.symbol,
              name: widget.name,
              price: widget.currentPrice,
              change: widget.change,
            ),
            BlocBuilder<StockCubit, StockState>(
              builder: (context, state) {
                if (state is StockLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MonthlyDetailsLoaded) {
                  final monthlyDetails = state.monthlyDetails;
                  final data = monthlyDetails.monthlyAdjustedTimeSeries;
                  final spots = data.entries.map((entry) {
                    final date = DateTime.parse(entry.key);
                    final close = double.parse(entry.value.the4Close);
                    return FlSpot(date.millisecondsSinceEpoch.toDouble(), close);
                  }).toList();
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.indigo[600]!,
                          width: 4
                      ),
                    ),
                    height: h / 3.3,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 2,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false, // Hide left titles
                              reservedSize: 0, // Remove left spacing
                              getTitlesWidget: (value, meta) {
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    value.toString(),
                                    style: TextStyle(
                                      fontSize: 1,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false, // Hide bottom titles
                              reservedSize: 0, // Remove bottom spacing
                              getTitlesWidget: (value, meta) {
                                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    date.timeZoneName,
                                    style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false, // Hide top titles
                              reservedSize: 0, // Remove top spacing
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false, // Hide right titles
                              reservedSize: 0, // Remove right spacing
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            left: BorderSide(
                              color: Theme.of(context).colorScheme.secondary, // Left border
                              width: 1,
                            ),
                            bottom: BorderSide(
                              color: Theme.of(context).colorScheme.secondary, // Bottom border
                              width: 1,
                            ),
                            right: BorderSide.none, // Remove right border
                            top: BorderSide.none, // Remove top border
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is StockError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
            const SizedBox(height: 20,),
            const CustomDivider(),
            DetailedContainer(
              currentPrice: widget.currentPrice,
              highestPrice: widget.highestPrice,
              lowestPrice: widget.lowestPrice,
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(child: CustomButton(buttonText: "Buy", onTap: () {})),
                const SizedBox(width: 10),
                Expanded(
                  child: isAdding? Center(child: CircularProgressIndicator())
                  :CustomButton(
                    buttonText: "Add to Watchlist",
                    onTap: () {
                      _addToWatchlist();
                    },
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


