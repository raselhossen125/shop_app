// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_string_interpolations, deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your  Cart"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 3,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cartData.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cartData: cartData),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: (ctx, index) => CartItem(
                cartData.items.values.toList()[index].id,
                cartData.items.keys.toList()[index],
                cartData.items.values.toList()[index].title,
                cartData.items.values.toList()[index].quantity,
                cartData.items.values.toList()[index].price,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cartData,
  }) : super(key: key);

  final Cart cartData;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cartData.totalAmount <=0 || _isLoading) ? null : () async{
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Orders>(context, listen: false).addOrder(
          widget.cartData.items.values.toList(),
          widget.cartData.totalAmount,
        );
        setState(() {
          _isLoading = false;
        });
        widget.cartData.clear();
      },
      child: _isLoading ? CircularProgressIndicator() : Text(
        "Order Now",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
