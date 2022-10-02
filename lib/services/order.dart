import 'package:asbeza_app/models/order.dart';

class OrderService {
  CreatedOrder? orders;
  Future<CreatedOrder?> createOrder(OrderInput orderInput) async {
    return Future.delayed(const Duration(seconds: 2), () {
      orders = CreatedOrder(
        orderId: 'order${DateTime.now().second}',
        orderNumber: "123456789",
        deliveryDate: DateTime.now().add(const Duration(days: 3)).toString(),
        orderedItems: orderInput,
      );
      return orders;
    });
  }

  Future<CreatedOrder> getOrders() {
    return Future.delayed(const Duration(seconds: 2), () {
      return orders!;
    });
  }
}
