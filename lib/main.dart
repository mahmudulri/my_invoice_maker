import 'dart:async';
import 'dart:ui';
import 'package:invoice_maker/controllers/mycontroller.dart';
import 'package:invoice_maker/draftscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/dashboard.dart';
import 'package:invoice_maker/screens/sign_in_screen.dart';

import 'controllers/order_status_controller.dart';
import 'order_notifier.dart/order_notifier.dart';
import 'screens/splash_screen.dart';
import 'services/background_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  box = GetStorage();

  // await initializedService();

  runApp(MyApp());
}

var box = GetStorage();

// Future<void> initializedService() async {
//   final service = FlutterBackgroundService();
//   box.write("name", "mahmudul");

//   IO.Socket socket = IO.io(
//     'https://api-vpro-hetz-afnet.afghannet.net:6001',
//     IO.OptionBuilder()
//         .setTransports(['websocket'])
//         .disableAutoConnect()
//         .setQuery({'EIO': '3'})
//         .build(),
//   );

//   socket.connect();

//   socket.onConnect((_) {
//     print('✅ (Background) Connected to WebSocket');

//     socket.emit('subscribe', {
//       'channel': 'reseller-173-order-channel',
//     });
//   });

//   socket.on('ChangeOrderStatus', (data) async {
//     print('🚀 (Background) ChangeOrderStatus: $data');

//     // 🔔 Show notification here when message received
//     FlutterLocalNotificationsPlugin notificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('flutter_logo');

//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await notificationsPlugin.initialize(initializationSettings);

//     // final box = Get.find<GetStorage>();

//     var orderId = data[1]['order_id'];

//     var status = data[1]['message'];
//     box.write("orderID", orderId.toString());
//     print("Printig after save........." + box.read("orderID"));

//     // if (orderId != null && orderId.toString().isNotEmpty) {
//     //   print("-------" + mycontroller.mydata.toString());
//     // }

//     await notificationsPlugin.show(
//       DateTime.now().millisecondsSinceEpoch.hashCode,
//       "Order Update ✅",
//       "Order ID: $orderId - Status: $status",
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'channelId',
//           'channelName',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//     );
//   });

//   socket.onDisconnect((_) {
//     print('❌ (Background) Disconnected from WebSocket');
//   });

//   socket.onConnectError((error) {
//     print('⚠️ (Background) Connect Error: $error');
//   });

//   await service.configure(
//       iosConfiguration: IosConfiguration(),
//       androidConfiguration: AndroidConfiguration(
//         onStart: onstart,
//         isForegroundMode: true,
//         foregroundServiceTypes: [AndroidForegroundType.dataSync],
//       ));
//   await service.startService();
// }

// @pragma('vm:entry-point')
// void onstart(ServiceInstance service) async {
//   DartPluginRegistrant
//       .ensureInitialized(); // ✅ if you use plugins (important for background)

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//     // service.on('setAsBackground').listen((event) {
//     //   service.setAsBackgroundService();
//     // });
//     service.on('stopService').listen((event) {
//       service.stopSelf();
//     });
//     // ✅ Immediately set your custom foreground notification
//     await service.setForegroundNotificationInfo(
//       title: "🚀 Socket Service",
//       content: "Listening for order updates...",
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: DashBoard(),
    );
  }
}
