import 'package:flutter/material.dart';
import 'package:stock_quote_app/screens/pages/profile_page.dart';

AppBar CustomAppBar(BuildContext context, String? title, String image) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    centerTitle: false,
    leading: InkWell(
      onTap: () {
        if(image.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: image.isNotEmpty ?
      const Icon(
        Icons.menu,
        color: Colors.white,
        size: 30,
      ): const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 25,
      ),
    ),
    title: Text(
      title?? "Registration",
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    actions: [
      image.isNotEmpty?
      InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
        },
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10,)
          ],
        ),
      ): const SizedBox()
    ],
  );
}