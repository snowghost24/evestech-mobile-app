import 'dart:async';
import 'dart:developer' as developer;
import 'package:evestech/providers/socket.dart';
import 'package:evestech/screens/discussion_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'constants.dart';
import 'models/device_info.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'screens/auth_screen.dart';
import 'screens/bottom_navigation_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/create_edit_product_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/test_screen.dart';
import 'screens/user_product_screen.dart';
import 'services/custom_theme.dart';
import 'services/helpers.dart';

void main() {
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (dynamic error, dynamic stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var deviceInfo = DeviceInfo();

  @override
  void initState() {
    super.initState();
    deviceInfo.initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => deviceInfo),
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => Helpers()),
        ChangeNotifierProxyProvider<Auth, Socket>(
          create: (ctx) => Socket(),
          update: (BuildContext context, value, Socket? previous) =>
              Socket()..update(value),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(),
          update: (BuildContext context, value, Products? previous) =>
              Products()..update(value),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      // causes the app to be rebuilt everytime there is a achange in auth
      child: Consumer<Auth>(
        builder: (ctx, authData, _) {
          return MaterialApp(
            onGenerateRoute: ((settings) {
              // This is also invoked for incoming deep links
              // ignore: avoid_print
              print('onGenerateRoute: $settings');
              return null;
            }),
            title: Constants.companyName,
            theme: CustomTheme.lightTheme,
            home: authData.isAuth
                ? const BottomNavigationBarScreen()
                : FutureBuilder(
                    future: authData.tryAutoLogin(),
                    builder: (_, authResultSnapshot) {
                      if (authResultSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LoadingScreen();
                      } else {
                        return const AuthScreen();
                      }
                    }),
            routes: {
              AuthScreen.routeName: (_) => const AuthScreen(),
              TestScreen.routeName: (_) => const TestScreen(),
              ProductDetailScreen.routeName: (context) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (_) => const CartScreen(),
              OrdersScreen.routeName: (_) => const OrdersScreen(),
              UserProductScreen.routeName: (_) => const UserProductScreen(),
              CreateEditProduct.routeName: (_) => const CreateEditProduct(),
              DiscussionScreen.routeName: (_) => const DiscussionScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
