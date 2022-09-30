import 'package:asbeza_app/app/colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.onPressed,
    this.isAdded,
  }) : super(key: key);
  final String? text;
  final Function? onPressed;
  final bool? isAdded;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.grey)),
        primary: Colors.white,
        backgroundColor: isAdded! ? bgColor : Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
      ),
      onPressed: onPressed as void Function()?,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            text!,
            style: TextStyle(
              fontSize: 18,
              color: isAdded! ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
