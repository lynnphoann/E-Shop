import 'package:eshop/Providers/Product.dart';
import 'package:eshop/Providers/Products.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _newProduct = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var isInit = true;
  bool loadingScreen = false;

  @override
  void initState() {
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
      if ((!_imageUrlController.text.startsWith("http") &&
          !_imageUrlController.text.startsWith("https"))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final String? productId =
          ModalRoute.of(context)!.settings.arguments as String?;

      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _newProduct = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      } else {
        return;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final valid = _formkey.currentState!.validate();
    if (valid) {
      _formkey.currentState!.save();
      setState(() {
        loadingScreen = true;
      });

      if (_editedProduct.id != null) {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id!, _editedProduct);
      } else {
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(_editedProduct);
        } catch (error) {
          await showDialog<void>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("An error occured"),
              content: Text("Something is Wrong"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Continue"),
                )
              ],
            ),
          );
        }
        // finally {
        //   setState(() {
        //     loadingScreen = false;
        //   });
        //   Navigator.of(context).pop();
        // }
      }
      setState(() {
        loadingScreen = false;
      });
      Navigator.of(context).pop();
    }
    return;
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
      body: loadingScreen
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
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
                        initialValue: _newProduct['title'],
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
                            // isFavorite: _editedProduct.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please put a title";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _newProduct['price'],
                        decoration: InputDecoration(labelText: "Price"),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(newValue!),
                            imageUrl: _editedProduct.imageUrl,
                            // isFavorite: _editedProduct.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a price";
                          }
                          if (double.tryParse(value) == null) {
                            return "please enter a number";
                          }
                          if (double.parse(value) <= 0) {
                            return "please enter a number greater than 0";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _newProduct['description'],
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
                            // isFavorite: _editedProduct.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please add some description";
                          }
                          if (value.length <= 10) {
                            return "Your description is too short";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
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
                            child: _imageUrlController.text.isNotEmpty &&
                                    (_imageUrlController.text
                                            .startsWith("http") ||
                                        _imageUrlController.text
                                            .startsWith("https"))
                                ? Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  )
                                : const Center(
                                    child: Text(
                                      "Enter Url",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Image Url"),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                setState(() {});
                                FocusScope.of(context).unfocus();
                              },
                              focusNode: _imageUrlFocusNode,
                              controller: _imageUrlController,
                              onFieldSubmitted: (_) {
                                setState(() {});
                              },
                              onSaved: (newValue) {
                                _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: newValue!,
                                  // isFavorite: _editedProduct.isFavorite,
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please add Image Url";
                                }
                                if (!value.startsWith("http") &&
                                    !value.startsWith("https")) {
                                  return "please enter valid Url";
                                }
                                // if (!value.endsWith(".jpg") &&
                                //     !value.endsWith(".jpeg") &&
                                //     !value.endsWith(".png")) {
                                //   return "please enter image Url";
                                // }
                                return null;
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
