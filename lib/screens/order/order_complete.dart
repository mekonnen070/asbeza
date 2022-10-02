import 'package:asbeza_app/helpers/complete_order_summary.dart';
import 'package:asbeza_app/providers/CartProvider.dart';
import 'package:asbeza_app/providers/counter_provider.dart';
import 'package:asbeza_app/screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen(
      {Key? key,
      required this.orderNumber,
      required this.deliveryDate,
      // required this.items,
      required this.shippingDetail})
      : super(key: key);
  final String orderNumber, deliveryDate, shippingDetail;
  // final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    CountersProvider countersProvider =
        Provider.of<CountersProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SvgPicture.asset("assets/svg/success.svg"),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Thank you for",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "shopping with Asbeza.",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Your orders are on the way.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.removeAll();
                  countersProvider.setTabIndex(0);
                  Future.delayed(const Duration(milliseconds: 50)).then(
                      (value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard())));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30))),
                    alignment: Alignment.center),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    "BACK TO SHOPPING",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CompleteOrderSummary(
                orderNumber: orderNumber,
                shippingDetail: shippingDetail,
                deliveryDate: deliveryDate,
                items: cartProvider.items),
          ]),
        ),
      ),
    );
  }
}
