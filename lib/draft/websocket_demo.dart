// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import '../services/notification_service.dart';

// class WebsocketDemo extends StatefulWidget {
//   WebsocketDemo({Key? key}) : super(key: key);

//   @override
//   State<WebsocketDemo> createState() => _WebsocketDemoState();
// }

// class _WebsocketDemoState extends State<WebsocketDemo> {
//   late IO.Socket socket;
//   String orderStatus = "Waiting for order updates...";

//   final FreeNotificationService _notificationService =
//       FreeNotificationService();

//   @override
//   void initState() {
//     super.initState();
//     _notificationService.initNotification();
//     connectToSocket();
//   }

//   void connectToSocket() {
//     socket = IO.io(
//       'https://api-vpro-hetz-afnet.afghannet.net:6001',
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .setQuery(
//               {'EIO': '3'}) // Force Engine.IO v3 to match Laravel Echo Server
//           .build(),
//     );

//     socket.connect();

//     socket.onConnect((_) {
//       print('✅ Connected to WebSocket Server');

//       // Correct subscription payload (must be object not raw string)
//       socket.emit('subscribe', {
//         'channel': 'reseller-173-order-channel',
//       });
//     });

//     // });

//     socket.on('ChangeOrderStatus', (data) {
//       print('🚀 ChangeOrderStatus event received: $data');
//       var orderId = data[1]['order_id'];
//       var status = data[1]['status'];
//       var message = data[1]['message'];
//       // print('🆔 Order ID: $orderId');
//       _notificationService.showNotification(
//         title: "Confirmed ✅",
//         body: " $orderId",
//       );

//       if (data != null && data is Map) {
//         setState(() {
//           orderStatus = data['message'] ?? "Unknown Status";
//           print(orderStatus);
//         });
//       }
//     });

//     socket.onConnectError((error) {
//       print('⚠️ Connect Error: $error');
//     });

//     socket.onError((error) {
//       print('⚠️ General Error: $error');
//     });

//     socket.onDisconnect((_) {
//       print('❌ Disconnected from WebSocket');
//     });
//   }

//   // @override
//   // void dispose() {
//   //   socket.dispose();
//   //   super.dispose();
//   //   print('🔌 Socket disposed');
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("WebSocket Demo"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               orderStatus,
//               style: const TextStyle(fontSize: 24),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (socket.disconnected) {
//                   socket.connect();
//                   print('🔁 Trying to reconnect manually...');
//                 }
//               },
//               child: const Text("Reconnect"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
