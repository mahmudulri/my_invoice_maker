import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebsocketDemo extends StatefulWidget {
  WebsocketDemo({Key? key}) : super(key: key);

  @override
  State<WebsocketDemo> createState() => _WebsocketDemoState();
}

class _WebsocketDemoState extends State<WebsocketDemo> {
  late IO.Socket socket;
  String orderStatus = "Waiting for order updates...";

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io(
      'https://api-vpro-hetz-afnet.afghannet.net:6001',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connect (we control when to connect)
          .setQuery(
              {'EIO': '3'}) // Force Engine.IO v3 to match Laravel Echo Server
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('✅ Connected to WebSocket Server');

      // Correct subscription payload (must be object not raw string)
      socket.emit('subscribe', {
        'channel': 'reseller-173-order-channel',
      });

      // Listen to ALL events for debugging
      socket.on('ChangeOrderStatus', (data) {
        print('🚀 ChangeOrderStatus event received: $data');
        if (data != null && data is Map) {
          setState(() {
            orderStatus = data['status'] ?? "Unknown Status";
          });
        }
      });
    });

    socket.onConnectError((error) {
      print('⚠️ Connect Error: $error');
    });

    socket.onError((error) {
      print('⚠️ General Error: $error');
    });

    socket.onDisconnect((_) {
      print('❌ Disconnected from WebSocket');
    });

    // Listen specifically to 'ChangeOrderStatus' event
    socket.on('ChangeOrderStatus', (data) {
      print('🚀 ChangeOrderStatus event received: $data');

      if (data != null && data is Map) {
        setState(() {
          orderStatus = data['status'] ?? "Unknown Status";
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order status : ${data['status']}'),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
    print('🔌 Socket disposed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebSocket Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              orderStatus,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (socket.disconnected) {
                  socket.connect();
                  print('🔁 Trying to reconnect manually...');
                }
              },
              child: const Text("Reconnect"),
            ),
          ],
        ),
      ),
    );
  }
}
