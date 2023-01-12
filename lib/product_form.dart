import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'product_provider.dart';

class ProductForm extends StatefulWidget {
  final bool isUpdating;
  final int index;

  ProductForm({
    this.isUpdating = false,
    this.index = 0,
  });

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _rankController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdating) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      final product = productProvider.productList[widget.index];
      _nameController.text = product.name;
      _priceController.text = product.price.toString();
      _quantityController.text = product.quantity.toString();
      _rankController.text = product.rank.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdating ? 'Modifier produit' : 'Ajouter produit'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Entrez un nom';
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Entrez un prix';
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantité'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Entrez une quantité';
                },
              ),
              TextFormField(
                controller: _rankController,
                decoration: InputDecoration(labelText: 'Rang'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Entrez un rang';
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text(widget.isUpdating ? 'Modifier' : 'Ajouter'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      name: _nameController.text,
                      price: double.parse(_priceController.text),
                      quantity: int.parse(_quantityController.text),
                      rank: int.parse(_rankController.text),
                    );
                    final productProvider =
                        Provider.of<ProductProvider>(context, listen: false);
                    if (widget.isUpdating) {
                      productProvider.updateProduct(widget.index, product);
                    } else {
                      productProvider.addProduct(product);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
