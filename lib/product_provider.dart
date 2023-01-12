import 'package:flutter/material.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _productList = [];
  List<Product> get productList {
    return [..._productList];
  }

  void addProduct(Product product) {
    _productList.add(product);
    notifyListeners();
  }

  void updateProduct(int index, Product product) {
    _productList[index] = product;
    notifyListeners();
  }

  void deleteProduct(int index) {
    _productList.removeAt(index);
    notifyListeners();
  }
}
