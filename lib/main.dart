// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/products.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> pokeballRedSwatch = {
      50: Color.fromRGBO(25, 25, 112, 0.1),
      100: Color.fromRGBO(25, 25, 112, 0.2),
      200: Color.fromRGBO(25, 25, 112, 0.3),
      300: Color.fromRGBO(25, 25, 112, 0.4),
      400: Color.fromRGBO(25, 25, 112, 0.5),
      500: Color.fromRGBO(25, 25, 112, 0.6),
      600: Color.fromRGBO(25, 25, 112, 0.7),
      700: Color.fromRGBO(25, 25, 112, 0.8),
      800: Color.fromRGBO(25, 25, 112, 0.9),
      900: Color.fromRGBO(25, 25, 112, 1.0),
    };
    MaterialColor pokeballRed = MaterialColor(0xff293462, pokeballRedSwatch);
    return ChangeNotifierProvider.value(
      value: Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: pokeballRed,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato"),
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
