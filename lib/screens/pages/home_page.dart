import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stock_quote_app/config/assets_path.dart';
import 'package:stock_quote_app/screens/support_screens/stock_list_view.dart';
import 'package:stock_quote_app/widgets/custom_app_bar.dart';
import 'package:stock_quote_app/widgets/custom_divider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCountry;
  TextEditingController searchController = TextEditingController();
  TextEditingController countryController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final w =  MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(context, "Home", "pic"),
      body: Column(
        children: [
          // Search Bar Widget
          const SizedBox(height: 15,),
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
          // Country Selection Logic
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Country",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: 3,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.primaryContainer
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: w/3,
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  countryController.text==""? "Country" : countryController.text,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: true, // optional. Shows phone code before the country name.
                                    onSelect: (Country country) {
                                      countryController.text = country.name;
                                      setState(() { });
                                    },
                                  );
                                },
                                child: Icon(
                                    Icons.arrow_drop_down
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Lottie.asset(
                      LottiePath.homeLottie,
                      fit: BoxFit.fill,
                      height: 120
                  ),
                ),
              ],
            ),
          ),
          const CustomDivider(),
          const SizedBox(height: 10,),
          const StockListView(),
        ],
      ),
    );
  }

}
