import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'product-detail';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    // use false here when you only want to grab values
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    print(loadedProduct.title);
    print(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(height:10),
          Text(
            '\$${loadedProduct.price}',
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(loadedProduct.description, textAlign: TextAlign.center, style: const TextStyle( fontSize: 18))
        ]),
      ),
      //
    );
  }
}
