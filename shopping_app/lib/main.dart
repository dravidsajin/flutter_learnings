import 'package:flutter/material.dart';
import 'package:shopping_app/pages/homepage.dart';
import 'package:shopping_app/pages/product_details_page.dart';
import 'global_variables.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Lato",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(254, 246, 1, 1),
          primary: const Color.fromRGBO(254, 246, 1, 1),
        ),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
        )),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // home: ProductDetailsPage(
      //   product: products[0],
      // ),
    );
  }
}
