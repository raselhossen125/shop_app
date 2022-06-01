// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, unused_field, prefer_final_fields

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
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit  Product"),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm;
            },
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
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    title: _editProduct.title,
                    description: _editProduct.description,
                    price: double.parse(value.toString()),
                    imageUrl: _editProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Descripton"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
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
