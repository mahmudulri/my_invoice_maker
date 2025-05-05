import 'dart:ui';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import 'notification_service.dart';

final FreeNotificationService _notificationService = FreeNotificationService();

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  final socket = IO.io(
    'https://api-vpro-hetz-afnet.afghannet.net:6001',
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
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
  });

  socket.on('ChangeOrderStatus', (data) {
    print('🚀 ChangeOrderStatus event received: $data');
    var orderId = data[1]['order_id'];
    var status = data[1]['status'];
    var message = data[1]['message'];
    // print('🆔 Order ID: $orderId');
    _notificationService.showNotification(
      title: "Confirmed ✅",
      body: " $orderId",
    );

    // if (data != null && data is Map) {
    //   setState(() {
    //     orderStatus = data['message'] ?? "Unknown Status";
    //     print(orderStatus);
    //   });
    // }
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
}

bool onIosBackground(ServiceInstance service) {
  // iOS background fetch logic (limited)
  return true;
}
