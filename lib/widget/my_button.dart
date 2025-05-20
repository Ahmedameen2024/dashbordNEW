import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final String titel;
  final VoidCallback onpressed;

  const MyButton(
      {super.key,
      required this.color,
      required this.titel,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 30,
          height: 42,
          child: Text(
            titel,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
