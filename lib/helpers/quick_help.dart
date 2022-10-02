import 'dart:io';

import 'package:asbeza_app/providers/CartProvider.dart';
import 'package:asbeza_app/providers/counter_provider.dart';
import 'package:asbeza_app/screens/cart/cart_screen.dart';
import 'package:asbeza_app/widgets/cart_item_length.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../animations/snack_bar_pro.dart';
import '../animations/top_snack_bar.dart';

class QuickHelp {
  static bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  static bool isDarkModeNoContext() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark;
  }

  static void showAppNotification(
      {required BuildContext context, String? title, bool isError = true}) {
    showTopSnackBar(
      context,
      isError
          ? SnackBarPro.error(
              title: title!,
            )
          : SnackBarPro.success(
              title: title!,
            ),
    );
  }

  static appExitDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text(
                'Do you want close the app?',
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                    },
                    child: const Text('Yes.')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No.")),
              ],
            ));
  }

  static appBar(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    CountersProvider countersProvider =
        Provider.of<CountersProvider>(context, listen: false);
    return AppBar(
      titleSpacing: 5.0,
      backgroundColor: Colors.white,
      title: SvgPicture.asset(
        'assets/svg/logo.svg',
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (cartProvider.items.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const CartScreen(),
                      ),
                    );
                    // countersProvider.setTabIndex(1);
                  }
                },
                child: SizedBox(
                  width: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: SvgPicture.asset(
                          "assets/svg/bag.svg",
                        ),
                      ),
                      const Positioned(
                        left: 30,
                        top: -5,
                        child: CartItemLength(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/random_profile.jpg'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
