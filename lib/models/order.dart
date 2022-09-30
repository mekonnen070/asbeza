class IOrderForm {
  late String phoneNumber,
      firstName,
      lastName,
      add1,
      add2,
      city,
      country,
      direction;

  IOrderForm({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.add1,
    required this.add2,
    required this.city,
    required this.country,
    required this.direction,
  });

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "firstName": firstName,
        "lastName": lastName,
        "add1": add1,
        "add2": add2,
        "city": city,
        "country": country,
        "direction": direction,
      };

  factory IOrderForm.fromJson(Map<String, dynamic> json) => IOrderForm(
        phoneNumber: json["phoneNumber"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        add1: json["add1"],
        add2: json["add2"],
        city: json["city"],
        country: json["country"],
        direction: json["direction"],
      );

  @override
  String toString() {
    return 'phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, add1: $add1, add2: $add2, city: $city, country: $add2, direction: $direction';
  }
}

class CreateOrderResult {
  CreateOrderResult({
    required this.createOrder,
  });

  CreatedOrder createOrder;

  factory CreateOrderResult.fromJson(Map<String, dynamic> json) =>
      CreateOrderResult(
        createOrder: CreatedOrder.fromJson(json["createOrder"]),
      );

  @override
  String toString() {
    return 'createOrder: $createOrder';
  }
}

class OrderItemInput {
  late String orderId;
  late String productId;
  late int quantity;

  OrderItemInput({
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() =>
      {"orderId": orderId, "productId": productId, "quantity": quantity};
}

class OrderInput {
  late String customerphoneNumber;
  late String customerFullName;
  late String customerAddress1;
  late String customerAddress2;
  late String customerCity;
  late String country;
  late String directionCode;
  late List<OrderItemInput> orderItems;

  OrderInput({
    required this.customerphoneNumber,
    required this.customerFullName,
    required this.customerAddress1,
    required this.customerAddress2,
    required this.customerCity,
    required this.country,
    required this.directionCode,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() => {
        "customerphoneNumberPhone": customerphoneNumber,
        "customerFullName": customerFullName,
        "customerAddress1": customerAddress1,
        "customerAddress2": customerAddress2,
        "customerCity": customerCity,
        "country": country,
        "directionCode": directionCode,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class CreatedOrder {
  late String orderId;
  late String orderNumber;
  late String deliveryDate;
  late OrderInput orderedItems;

  CreatedOrder({
    required this.orderId,
    required this.orderNumber,
    required this.deliveryDate,
    required this.orderedItems,
  });

  factory CreatedOrder.fromJson(Map<String, dynamic> json) => CreatedOrder(
        orderId: json["orderId"],
        orderNumber: json["orderNumber"],
        deliveryDate: json["deliveryDate"],
        orderedItems: json["orderedItems"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderNumber": orderNumber,
        "deliveryDate": deliveryDate,
        "orderedItems": orderedItems,
      };

  @override
  String toString() {
    return 'orderId: $orderId, orderNumber: $orderNumber, deliveryDate: $deliveryDate';
  }
}
