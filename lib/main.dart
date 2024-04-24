import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tej_mart/Features/init_screen.dart';
import 'package:tej_mart/constants/colors.dart';
import 'package:tej_mart/providers/cart_provider.dart';
import 'package:tej_mart/providers/customer_provider.dart';
import 'package:tej_mart/providers/salse_user_provider.dart';
import 'package:tej_mart/routes.dart';

void main() { 
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SalesExecutiveProvider()),
      ChangeNotifierProvider(create: (_) => CustomerProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: white,
        colorScheme: ColorScheme.fromSeed(seedColor: white),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
            surfaceTintColor: white, elevation: 0, backgroundColor: white),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const MyInitScreen(),
    );
  }
}
