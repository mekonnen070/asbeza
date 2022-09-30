import 'package:flutter/material.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({Key? key}) : super(key: key);

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("Bonus page"),
      ),
    );
  }
}
