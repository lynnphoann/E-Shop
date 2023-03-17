import 'package:eshop/Providers/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routename = "/editProductScreen";
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(imageUrlLoseFocus);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(imageUrlLoseFocus);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void imageUrlLoseFocus() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _formkey.currentState!.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save_alt_rounded))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (newValue) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: newValue!,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (newValue) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(newValue!),
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  textInputAction: TextInputAction.newline,
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  onSaved: (newValue) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: newValue!,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Center(
                              child: Text(
                                "Enter Url",
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Image Url"),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          setState(() {});
                          FocusScope.of(context).unfocus();
                        },
                        focusNode: _imageUrlFocusNode,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: newValue!,
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
