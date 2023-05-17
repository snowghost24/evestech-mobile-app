import 'package:evestech/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket with ChangeNotifier {
  late String authToken;
  late IO.Socket socket;

  void update(Auth authModel) {
    authToken = authModel.token!;
  }

  IO.Socket getSocket() {
    final IO.Socket localSocket = IO.io(
        'https://jose.evestech.com',
        IO.OptionBuilder()
            .disableAutoConnect()
            .setTransports(['websocket'])
            .setPath('/api/realtime/ws') // optional
            .build());
    localSocket.connect();
    localSocket.onConnect((_) {
      print('connect');
    });
    // socket.onAny((event, data) {
    //   print("we are on any");
    //   print(event);
    //   print(data);
    // });
    localSocket.onDisconnect((_) => print('disconnect'));
    localSocket.on('connect_error', (error) => print("connect error $error"));
    socket = localSocket;
    return socket;
  }
}
