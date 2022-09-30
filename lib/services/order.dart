import 'package:asbeza_app/models/order.dart';

class OrderService {
  static Future<CreatedOrder?> createOrder(OrderInput orderInput) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return CreatedOrder(
        orderId: 'order${DateTime.now().second}',
        orderNumber: "123456789",
        deliveryDate: DateTime.now().add(const Duration(days: 3)).toString(),
        orderedItems: orderInput,
      );
    });
  }
}
