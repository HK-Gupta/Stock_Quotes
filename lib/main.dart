import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_quote_app/config/theme.dart';
import 'package:stock_quote_app/cubit_implementation/stock_cubit.dart';
import 'package:stock_quote_app/cubit_implementation/stock_repositories/stock_repository.dart';
import 'package:stock_quote_app/cubit_implementation/stock_state.dart';
import 'package:stock_quote_app/screens/auth_screens/login_screen.dart';
import 'package:stock_quote_app/screens/auth_screens/register_screen.dart';
import 'package:stock_quote_app/screens/bottom_navigation.dart';
import 'package:stock_quote_app/screens/pages/details_page.dart';
import 'package:stock_quote_app/screens/pages/profile_page.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockCubit(StockRepository()),
      child: MaterialApp(
        title: 'Stock Quotes',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: const BottomNavigation(),
        // home: const LoginScreen(),
      ),
    );
  }
}

