// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, unused_field, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _ImageUrlController = TextEditingController();
  final _imageUrlfocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct = Product(
      id: null.toString(), title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageUrlfocusNode.addListener(updateUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlfocusNode.removeListener(updateUrl);
    _imageUrlfocusNode.dispose();
    super.dispose();
  }

  void updateUrl() {
    if (!_imageUrlfocusNode.hasFocus) {
      if (_ImageUrlController.text.isEmpty ||
          (!_ImageUrlController.text.startsWith('http') &&
              !_ImageUrlController.text.startsWith('https')) ||
          (!_ImageUrlController.text.endsWith('.png') &&
              !_ImageUrlController.text.endsWith('.jpg') &&
              !_ImageUrlController.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(_editProduct.title);
    print(_editProduct.price);
    print(_editProduct.description);
    print(_editProduct.imageUrl);
    print("Click here");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit  Product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide a value";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: null.toString(),
                    title: value!,
                    description: _editProduct.description,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide a price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  if (double.parse(value) <= 0) {
                    return "Please enter a number greater than zero";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: null.toString(),
                    title: _editProduct.title,
                    description: _editProduct.description,
                    price: double.parse(value!),
                    imageUrl: _editProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Descripton"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide a descripton";
                  }
                  if (value.length < 10) {
                    return "Should be at least 10 carecters long";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: null.toString(),
                    title: _editProduct.title,
                    description: value!,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _ImageUrlController.text.isEmpty
                        ? Text("Enater a URL")
                        : FittedBox(
                            child: Image.network(
                              _ImageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Image URL"),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      controller: _ImageUrlController,
                      focusNode: _imageUrlfocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter an image URL";
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return "Please enter a valid URL";
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('jpeg')) {
                          return "Please enter a valid image URL";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editProduct = Product(
                          id: null.toString(),
                          title: _editProduct.title,
                          description: _editProduct.description,
                          price: _editProduct.price,
                          imageUrl: value!,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
