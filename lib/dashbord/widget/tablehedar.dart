import 'package:flutter/material.dart';

class Tablehedar extends StatelessWidget {
  final String name;

  const Tablehedar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    // final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
