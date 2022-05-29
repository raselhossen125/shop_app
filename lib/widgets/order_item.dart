// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expander = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).buttonColor,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              "\$${widget.order.amount.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              DateFormat("dd/MM/yyyy  hh:mm").format(widget.order.dateTime),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expander = !_expander;
                });
              },
              icon: Icon(_expander ? Icons.expand_less : Icons.expand_more),
              color: Colors.white,
            ),
          ),
          if (_expander)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: min(widget.order.products.length * 20.00 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map((element) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              element.title,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            Text(
                              '${element.quantity}  x  \$${element.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
