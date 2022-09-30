import 'package:asbeza_app/providers/CartProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.selectedItem,
  }) : super(key: key);

  final CartItem selectedItem;

  @override
  State<CartCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<CartCard> {
  int selectedAmount = 1;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Card(
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        )),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      height: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: widget.selectedItem.product.images[0].url!,
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
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedItem.product.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.selectedItem.product.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () => cartProvider
                              .removeAnItem(widget.selectedItem.product),
                          child: SvgPicture.asset("assets/svg/remove.svg")),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              )),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.selectedItem.itemCount > 1) {
                              cartProvider.deductAdddedQuantity(
                                  widget.selectedItem.product);
                            }
                          },
                          child: SvgPicture.asset("assets/svg/minus.svg"),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          widget.selectedItem.itemCount.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () => cartProvider
                              .addNewQuantity(widget.selectedItem.product),
                          child: SvgPicture.asset("assets/svg/add.svg"),
                        ),
                      ],
                    ),
                    Text(
                      "\$${(widget.selectedItem.itemCount * widget.selectedItem.product.price).toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
