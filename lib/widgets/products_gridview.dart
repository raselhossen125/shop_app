// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'product_item.dart';

class ProductsGridview extends StatelessWidget {
  final bool showFavs;

  ProductsGridview(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    final productsData = showFavs ? product.favouriteItems : product.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: productsData.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: productsData[index],
        child: ProductItem(
          // productsData[index].id, 
          // productsData[index].title,
          // productsData[index].imageUrl
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
