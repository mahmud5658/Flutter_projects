import 'package:flutter/material.dart';

AppBar appBar() {
  return AppBar(
      title: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Flutter',
        style: TextStyle(
            color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Text(
        'Firebase',
        style: TextStyle(
            color: Colors.orange, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ],
  ));
}
