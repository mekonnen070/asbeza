// ignore_for_file: must_be_immutable

import 'package:asbeza_app/models/product.dart';
import 'package:asbeza_app/providers/CartProvider.dart';
import 'package:asbeza_app/widgets/AddToCatButton.dart';
import 'package:asbeza_app/widgets/shimmers/product_item_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final List<Product> products;
  ItemCard(
      {Key? key,
      this.loading = false,
      required this.product,
      required this.products})
      : super(key: key);

  bool isAdded = false;
  bool loading = false;

  bool isAlreadyProductInCart(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    bool isProductInCart = false;
    for (var item in cartProvider.items) {
      if (item.productId == product.productId) {
        isProductInCart = true;
      }
    }

    return isProductInCart;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: ProductItemShimmer());
    }

    if (products.isEmpty) {
      return const Center(
        child: Text(
          "No Product",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 0.25 * MediaQuery.of(context).size.width,
              height: 0.17 * MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.images[0].url!,
                      imageBuilder: (context, imageProvider) => Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      'assets/svg/discount.svg',
                      height: 38,
                    ),
                  ),
                  Positioned(
                    top: 9,
                    left: 9,
                    child: Text(
                      '${product.discount}%',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        product.vendorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AddToCartButton(
                            isInCart: isAlreadyProductInCart(context),
                            product: product),
                        IconButton(
                          onPressed: () =>
                              _callNumber(product.vendorPhoneNumber),
                          icon: const Icon(
                            Icons.phone,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _callNumber(phoneNumber) async {
    const number = '0859211788'; //set the number here

    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }
}
