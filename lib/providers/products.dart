// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';

import 'product.dart';

class Products with ChangeNotifier{
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.993,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      title: 'Chair',
      description: 'Brown Wooden Rocking Chair.',
      price: 78.99,
      imageUrl:
          'https://images.pexels.com/photos/4627515/pexels-photo-4627515.jpeg?cs=srgb&dl=pexels-engin-akyurt-4627515.jpg&fm=jpg',
    ),
    Product(
      id: 'p6',
      title: 'Purnima',
      description: 'Brown Wooden Rocking Chair.',
      price: 78.99,
      imageUrl:
          'https://scontent.fdac80-1.fna.fbcdn.net/v/t1.6435-9/81746006_679670262567138_8897776604869033984_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=QWH8EFF7utYAX-piTv9&_nc_ht=scontent.fdac80-1.fna&oh=00_AT9xoKTltltWJmRgQn19nwF_Mn5QFbdIj_RvsgYBRKTu5Q&oe=62B5B658',
    ),
    Product(
      id: 'p7',
      title: 'Pooja',
      description: 'Brown Wooden Rocking Chair.',
      price: 78.99,
      imageUrl:
          'https://scontent.fdac80-1.fna.fbcdn.net/v/t1.6435-9/156955775_4175254755826729_1185969317954708966_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=KOE5si_0-KoAX_2Qw3_&_nc_ht=scontent.fdac80-1.fna&oh=00_AT9XHiHlARa-zLkNUJM8oBOeKg-YMRueDYfeeXSOa5AYrQ&oe=62B5345D',
    ),
  ];

  // var _showFavouritesOnly = false;

  List<Product> get items{
    // if (_showFavouritesOnly){
    //   _items.where((element) => element.isFavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteItems{
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // void showFavouritesOnly() {
  //   _showFavouritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    notifyListeners();
  }
}