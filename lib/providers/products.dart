import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';
import 'product.dart';

class Products with ChangeNotifier {
  String? authToken =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2ZGE4NmU4MWJkNTllMGE4Y2YzNTgwNTJiYjUzYjUzYjE4MzA3NzMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmx1dHRlci10ZXN0LTcwY2I4IiwiYXVkIjoiZmx1dHRlci10ZXN0LTcwY2I4IiwiYXV0aF90aW1lIjoxNjgyMDE2Njg1LCJ1c2VyX2lkIjoiakZhdW9qQXVpamdoU0RvM0o1NGI3dTVNWTF6MSIsInN1YiI6ImpGYXVvakF1aWpnaFNEbzNKNTRiN3U1TVkxejEiLCJpYXQiOjE2ODIwMTY2ODUsImV4cCI6MTY4MjAyMDI4NSwiZW1haWwiOiJsb2xAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImxvbEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.PLl_bmTfsQlM2Tzh-vEgG5q2dLVTP9cuGkvDf1ZNu-boZD9HVtxUK9sfy5QH_AZnym2r9RKNbzimAeoBZLsz3T9aAgp8fK8j_czvsr0GAuwGMSPe1aUQF5JZ4754nUUbMEF_GJ2ZK1R23BlfRcJtcpGSNFxpf7wLZVkzoSvHQNhs-tzo14syQquia0YXRUT-3-ycwe8Ud-myoR6dx9kY9Qrha1AdWvVq5HmsUyrL5k48hKEdLnhDHoZqAJm1X5FsApPcQf6nGsE-ySy9dmIMZpLmFAUIZUiYMMH-mp_8NSsItnFHdPjiRTIoUXqRwsJdvTVVPi1Ca4LOSm514acdHw';

// this gives us access to authModel
  void update(Auth authModel) {
    print("assigning token in products");
    authToken = authModel.token;
    // print(authToken);
    // developer.log(authToken as String);
    // Do some custom work based on myModel that may call `notifyListeners`
  }

  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // you want to return a copy because you dont want to let them
  // direclty edi the items
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return [..._items.where((itm) => itm.isFavorite)].toList();
  }

  // void addProduct(Product product) {
  //   final newProduct = Product(
  //     title: product.title,
  //     description: product.description,
  //     price: product.price,
  //     imageUrl: product.imageUrl,
  //     id: DateTime.now().toString(),
  //   );
  //   _items.add(newProduct);
  //   notifyListeners();
  // }

  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };

  Future<void> fetchAndSetProducts() async {
    print("getching fetchAndSetProducts");
    final url = Uri.https('flutter-test-70cb8-default-rtdb.firebaseio.com',
        '/products.json', {'auth': authToken});
    try {
      // print(authToken);
      final response = await http.get(url);

      // print(json.decode(response.body.toString()));
      String jsonsDataString = response.body.toString();
      final _data = jsonDecode(jsonsDataString);
      print(_data.toString());

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print('response');
      //  print(response);
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      print('made it to list');
      // maps return key and value when you do foreach
      // extractedData.forEach((prodId, prodData) => {
      //       loadedProducts.add(Product(
      //         id: prodId,
      //         title: prodData['title'],
      //         description: prodData['description'],
      //         price: prodData['price'],
      //         isFavorite: false,
      //         imageUrl: prodData['imageUrl'],
      //       ))
      //     });
      // _items = loadedProducts;
      // print("fetch product ran");
      // notifyListeners();
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https('flutter-test-70cb8-default-rtdb.firebaseio.com',
        '/products.json', {'auth': authToken});
    try {
      // adds product to the database
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': false
          // 'creatorId': userId,
        }),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      // adds product to the to the provider
      _items.add(newProduct);
      notifyListeners();
      return Future.value();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https('flutter-test-70cb8-default-rtdb.firebaseio.com',
          '/products/$id.json', {'auth': authToken});
      await http.patch(
        url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price
        }),
      );
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https('flutter-test-70cb8-default-rtdb.firebaseio.com',
        '/products/$id.json', {'auth': authToken});
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      notifyListeners();
      throw const HttpException('Could not delete product.');
    } else {
      _items.removeWhere((prod) => prod.id == id);
    }
    notifyListeners();
  }
}
