import 'package:asbeza_app/app/colors.dart';
import 'package:asbeza_app/helpers/quick_help.dart';
import 'package:asbeza_app/providers/CartProvider.dart';
import 'package:asbeza_app/screens/cart/components/cartCard.dart';
import 'package:asbeza_app/screens/order/order_screen.dart';
import 'package:asbeza_app/utils/PriceCalculator.dart';
import 'package:asbeza_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final kBoldTextStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: QuickHelp.isDarkMode(context) ? Colors.white : Colors.black);

    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: bgColor,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Your Cart",
                  style: TextStyle(color: Colors.black)),
              // actions: [
              //   IconButton(
              //     onPressed: () {
              //       cartProvider.clearCart();
              //     },
              //     icon: const Icon(Icons.delete),
              //   )
              // ],
            ),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartProvider.items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CartCard(
                                  selectedItem: cartProvider.items[index]),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                            border: Border(
                          top:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "TOTAL INCL. TAX",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "\$${Price.calculateTotalPrice(cartProvider.items).toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Center(
                          child: DefaultButton(
                            isAdded: false,
                            text: 'PROCESS TO CHECKOUT',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const OrderScreen()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ));
            })));
  }
}
