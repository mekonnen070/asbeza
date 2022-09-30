import 'package:asbeza_app/models/product.dart';
import 'package:asbeza_app/providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartButton extends StatelessWidget {
  bool isInCart;
  Product product;

  Color bgColor = const Color(0xffebf1fd);

  AddToCartButton({
    Key? key,
    required this.isInCart,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    final text = isInCart ? 'ADDED' : 'ADD TO CART';

    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.grey)),
        primary: Colors.white,
        backgroundColor: isInCart ? bgColor : Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
      ),
      onPressed: isInCart
          ? () {
              cartProvider.removeAnItem(product);
            }
          : () {
              cartProvider.addNewItem(product);
            },
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: isInCart ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
