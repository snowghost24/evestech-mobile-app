import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../models/device_info.dart';
import '../providers/auth.dart';
import '../widgits/square_tiles.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// import '../models/api_client.dart';

class TestScreen extends StatelessWidget {
  static const routeName = '/test-screen';
  const TestScreen({super.key});
  // final clientRequests = ApiClient();

  // void handlePress(String token) {
  //   final IO.Socket socket = IO.io(
  //       'https://jose.evestech.com',
  //       OptionBuilder()
  //           .disableAutoConnect()
  //           .setTransports([
  //             'websocket'
  //           ]) // for Flutter or Dart VM // disable auto-connection
  //           .setQuery({'token': token})
  //           .setPath('/api/realtime/ws') // optional
  //           .build());
  //   socket.connect();
  //   socket.onConnect((_) {
  //     print('connect');
  //   });
  //   socket.onAny((event, data) {
  //     print("we are on any");
  //     print(event);
  //     print(data);
  //   });
  //   socket.onDisconnect((_) => print('disconnect'));
  //   socket.on('connect_error', (error) => print("connect error $error"));
  // }

  @override
  Widget build(BuildContext context) {
    var authContext = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Test Screen")),
      body: Column(
          // height: 60,
          // width: 300,
          // margin: const EdgeInsets.all(30),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10.0),
          //     color: Theme.of(context).colorScheme.onPrimary),
          children: [
            ElevatedButton(
                onPressed: () {
                  authContext.logout();
                },
                child: const Text("Logut")),
            ElevatedButton(
                onPressed: () {
                  // handlePress(authContext.token as String);
                },
                child: const Text("Run Socket")),
            Consumer<DeviceInfo>(builder: (_, deviceData, child) {
              return SquareTile(
                  imagePath: 'assets/images/google_icon.png',
                  handlePress: () {});
            })
          ]),
    );
  }
}
