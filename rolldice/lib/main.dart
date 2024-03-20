import 'package:flutter/material.dart';
import 'package:rolldice/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 46, 15, 101),
          Color.fromARGB(255, 50, 28, 149),
        ), 
      ),
    ),
  );
}
