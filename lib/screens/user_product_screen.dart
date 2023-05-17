import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgits/app_drawer.dart';
import '../widgits/user_product_item.dart';
import 'create_edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(CreateEditProduct.routeName);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      // when you pull down all the products are refreshed
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (_, i) {
                return Column(children: [
                  UserProductItem(
                      id: productsData.items[i].id,
                      title: productsData.items[i].title,
                      imageUrl: productsData.items[i].imageUrl),
                  const Divider()
                ]);
              }),
        ),
      ),
    );
  }
}
