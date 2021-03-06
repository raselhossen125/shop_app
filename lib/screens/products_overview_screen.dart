// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_gridview.dart';
import 'cart_screen.dart';

enum FilterOptins { favourite, all }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  var isInit = true;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
      isLoading = true;
    });
      Provider.of<Products>(context).faceAndSetProducts().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My  Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptins selectedValue) {
              setState(() {
                if (selectedValue == FilterOptins.favourite) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text("Only favourites"),
                value: FilterOptins.favourite,
              ),
              PopupMenuItem(
                child: Text("Show all"),
                value: FilterOptins.all,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
              color: Theme.of(context).accentColor,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator(),)
          : ProductsGridview(_showOnlyFavourites),
    );
  }
}
