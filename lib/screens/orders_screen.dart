// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/order-screen";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _ordersFuture;

  Future? _ontainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _ontainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your  Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, dataSnapshort) {
            if (dataSnapshort.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshort.error != null) {
                return Center(child: Text('An error occurred'));
              } else {
                return Consumer<Orders>(builder: (ctx, ordersData, child) {
                  return ListView.builder(
                    itemCount: ordersData.orders.length,
                    itemBuilder: (ctx, index) =>
                        OrderItem(ordersData.orders[index]),
                  );
                });
              }
            }
          }),
    );
  }
}
