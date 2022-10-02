import 'dart:collection';

import 'package:asbeza_app/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  CartItem(
      {required this.productId,
      required this.product,
      required this.itemCount});

  String productId;
  Product product;
  int itemCount;
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  bool _is_already = false;

  bool get is_already => _is_already;

  checkAdded(String id) {
    for (var i in _items) {
      i.productId == id;
      _is_already = true;
    }
    return _is_already;
    notifyListeners();
  }

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  void addNewItem(Product item) {
    _items
        .add(CartItem(productId: item.productId, product: item, itemCount: 1));
    notifyListeners();
  }

  void addNewQuantity(Product item) {
    List<CartItem> addCartQuantity = [];
    for (CartItem cart in items) {
      if (cart.productId == item.productId) {
        addCartQuantity.add(CartItem(
            productId: item.productId,
            product: item,
            itemCount: cart.itemCount + 1));
      } else {
        addCartQuantity.add(cart);
      }
    }
    _items = addCartQuantity;
    notifyListeners();
  }

  void deductAdddedQuantity(Product item) {
    List<CartItem> minusCartQuantity = [];
    for (CartItem cart in items) {
      if (cart.productId == item.productId) {
        minusCartQuantity.add(CartItem(
            productId: item.productId,
            product: item,
            itemCount: cart.itemCount - 1));
      } else {
        minusCartQuantity.add(cart);
      }
    }
    _items = minusCartQuantity;
    notifyListeners();
  }

  void removeAnItem(Product item) {
    _items =
        _items.where((product) => product.productId != item.productId).toList();
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
