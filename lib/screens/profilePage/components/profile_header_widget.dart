import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    Key? key,
    required this.paddingTop,
  }) : super(key: key);

  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5 + paddingTop,
      left: 0,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Expanded(child: SizedBox()),
            IconButton(
              icon: const Icon(Icons.phone, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
