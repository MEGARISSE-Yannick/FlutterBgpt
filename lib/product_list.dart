import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';
import 'product_form.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des produits'),
      ),
      body: ListView.builder(
        itemCount: productProvider.productList.length,
        itemBuilder: (BuildContext context, int index) {
          final product = productProvider.productList[index];
          return ListTile(
            leading: Text(product.name),
            title: Text(product.price.toString()),
            subtitle: Text(product.quantity.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(product.rank.toString()),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    productProvider.deleteProduct(index);
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductForm(
                      isUpdating: true,
                      index: index,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductForm();
              },
            ),
          );
        },
      ),
    );
  }
}
