// lib/notifiers/order_notifier.dart
import 'package:flutter/foundation.dart';

class OrderNotifier extends ValueNotifier<Map<String, String>> {
  OrderNotifier() : super({'orderId': '', 'orderStatus': ''});

  void update(String orderId, String status) {
    value = {
      'orderId': orderId,
      'orderStatus': status,
    };
    notifyListeners();
  }
}

final orderNotifier = OrderNotifier(); // global instance
