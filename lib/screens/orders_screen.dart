import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgits/app_drawer.dart';
import '../widgits/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'orders-list';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Orders")),
        drawer: const AppDrawer(),
        body: ListView.builder(
          itemBuilder: (_, index) {
            return OrderItemWidget(order: ordersData.orders[index]);
          },
          itemCount: ordersData.orders.length,
        ));
  }
}
