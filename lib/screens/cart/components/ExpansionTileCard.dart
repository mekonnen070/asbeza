import 'package:asbeza_app/helpers/quick_help.dart';
import 'package:flutter/material.dart';

class ExpansionChildrenCard extends StatelessWidget {
  const ExpansionChildrenCard(
      {Key? key, required this.product, required this.index})
      : super(key: key);

  final dynamic product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final kBoldTextStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: QuickHelp.isDarkMode(context) ? Colors.white : Colors.black);

    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 0.3 * MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(product['images'][index]['url']),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['name'],
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: kBoldTextStyle,
                      ),
                      Text(
                        product['description'],
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '\$${product['price']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
