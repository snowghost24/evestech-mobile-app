import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductGridItem extends StatelessWidget {
  static const routeName = 'product-item';

  // final String id;
  // final String title;
  // final String imageUrl;

  const ProductGridItem({
    super.key,
    // required this.id,
    // required this.imageUrl,
    // required this.title
  });

  // @override
  // Widget build(BuildContext context) {
  //   final product = Provider.of<Product>(context);
  //   print("product in product item");
  //   print(product.title);
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: GridTile(
  //       footer: GridTileBar(
  //         backgroundColor: Colors.black87,
  //         leading: IconButton(
  //             onPressed: () {
  //               product.toggleFavoriteStatus();
  //             },
  //             color: product.isFavorite ? Colors.redAccent : Colors.white,
  //             icon: Icon(
  //                 product.isFavorite ? Icons.favorite : Icons.favorite_border)),
  //         title: Text(product.title),
  //         trailing: IconButton(
  //             color: Theme.of(context).colorScheme.secondary,
  //             onPressed: () {},
  //             icon: const Icon(Icons.shopping_cart)),
  //       ),
  //       child: GestureDetector(
  //           onTap: () {
  //             Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
  //                 arguments: product.id);
  //           },
  //           child: Image.network(product.imageUrl, fit: BoxFit.cover)),
  //     ),
  //   );
  // }

// the topone use Provider.of this one uses Consumer
  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (ctx, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
                color: product.isFavorite ? Colors.redAccent : Colors.white,
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border)),
            title: Text(product.title),
            trailing: Consumer<Cart>(
                builder: (_, cart, child) => IconButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      cart.addItem(product.id, product.price, product.title);
                      // this hides current snack bar
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Added item to cart!',
                          ),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(product.id);
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart))),
          ),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: product.id);
              },
              child: Image.network(product.imageUrl, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
