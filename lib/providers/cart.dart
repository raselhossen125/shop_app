// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem>? _items = {};

  Map<String, CartItem> get items {
    return {..._items!};
  }

  int get itemCount {
    return _items!.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items!.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items!.containsKey(productId)) {
      _items!.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            quantity: value.quantity + 1,
            price: value.price),
      );
    } else {
      _items!.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items!.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String proId) {
    if (!_items!.containsKey(proId)) {
      return;
    }
    if (_items![proId]!.quantity > 1) {
      _items!.update(
        proId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    else {
      _items!.remove(proId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
