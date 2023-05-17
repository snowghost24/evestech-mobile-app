import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgits/cart_item_widgit.dart';
// import '../providers/cart.dart';
// import '../widgets/cart_item_widgit.dart';
// import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Cart cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('cart')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Row(children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 10),
                    Chip(
                      label: Text('\$${cartData.totalAmount}'),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ]),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cartData.items.values.toList(),
                          cartData.totalAmount,
                        );
                        cartData.clear();
                      },
                      child: const Text('Order Now'))
                ],
              )),
        ),
        const SizedBox(height: 10),
        Expanded(
            child: ListView.builder(
          itemBuilder: (_, index) {
            var item = cartData.items.values.toList()[index];
            return CartItemWidget(
                id: item.id,
                price: item.price,
                quantity: item.quantity,
                title: item.title);
          },
          itemCount: cartData.itemCount,
        ))
      ]),
    );
  }
}
