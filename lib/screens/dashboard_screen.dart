import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/badges.dart' as badges;

import '../providers/cart.dart';
import '../providers/products.dart';
import '../widgits/app_drawer.dart';
import '../widgits/products_grid.dart';
import 'cart_screen.dart';

enum FilterOptions { favorites, all }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showFavoritesOnly = false;
  bool _isLoading = true;
  void showFavoritesOnly() {
    setState(() {
      _showFavoritesOnly = true;
    });
  }

  void showAll() {
    setState(() {
      _showFavoritesOnly = false;
    });
  }

  @override
  void initState() {
    _isLoading = true;
    try {
      print("about to fetched products from initstate");
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts()
          .then((value) {
        print("fetched products from initstate");
        setState(() {
          _isLoading = false;
        });
      });
    } catch (e) {
      print("error was relaated");
    }

    super.initState();
  }

  Widget _shoppingCartBadge(itemCount) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeAnimation: const badges.BadgeAnimation.slide(
          // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
          // curve: Curves.easeInCubic,
          ),
      showBadge: itemCount >= 1,
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.red,
      ),
      badgeContent: Text(
        itemCount.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  if (selectedValue == FilterOptions.favorites) {
                    showFavoritesOnly();
                  } else {
                    showAll();
                  }
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: FilterOptions.favorites,
                        child: Text("Only Favorites"),
                      ),
                      const PopupMenuItem(
                        value: FilterOptions.all,
                        child: Text("Display all"),
                      )
                    ]),
            Consumer<Cart>(builder: (_, cartData, child) {
              return _shoppingCartBadge(cartData.itemCount);
            })
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(showFavs: _showFavoritesOnly),
        drawer: const AppDrawer());
  }
}
