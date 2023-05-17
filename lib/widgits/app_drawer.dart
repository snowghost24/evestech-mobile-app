import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop_app/screens/orders_screen.dart';
// import 'package:shop_app/screens/user_product_screen.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      AppBar(title: const Text("Orders")),
      const Divider(),
      ListTile(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
        title: const Text('Shop'),
        leading: const Icon(Icons.shop),
      ),
      // const Divider(),
      // ListTile(
      //   title: const Text('Orders'),
      //   onTap: () {
      //     Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
      //   },
      //   leading: const Icon(Icons.payment),
      // ),
      // const Divider(),
      // ListTile(
      //   title: const Text('Manage Products'),
      //   onTap: () {
      //     Navigator.of(context)
      //         .pushReplacementNamed(UserProductScreen.routeName);
      //   },
      //   leading: const Icon(Icons.edit),
      // ),
      const Spacer(),
      const Divider(),
      Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: ListTile(
          title: const Text('Logout'),
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<Auth>(context, listen: false).logout();
          },
          leading: const Icon(Icons.exit_to_app),
        ),
      )
    ]));
  }
}
