import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import 'product_grid_tem.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid({super.key, required this.showFavs});

  @override
  Widget build(BuildContext context) {
    // here we let it knwo what we want to listen to
    List<Product> loadedProducts;

    if (showFavs) {
      loadedProducts = Provider.of<Products>(context).favoriteItems;
    } else {
      loadedProducts = Provider.of<Products>(context).items;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (_, index) {
        //use value if the class being used as a value is already been created
        // like Product was already created in Products
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: const ProductGridItem(),
        );
        // try not to use the one below when looping
        // return ChangeNotifierProvider(
        //     create: (ctx) => loadedProducts[index],
        //     child: const ProductItem());
      },
      itemCount: loadedProducts.length,
    );
  }
}
