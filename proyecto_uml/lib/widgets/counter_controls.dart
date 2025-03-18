import 'package:flutter/material.dart';

Widget counterControles(VoidCallback increment,VoidCallback decrement,VoidCallback refresh) {
  return Row(
    children: [
      IconButton(
        onPressed: increment,
        icon: const Icon(Icons.add),
      ),
      IconButton(
        onPressed: decrement,
        icon: const Icon(Icons.remove),
      ),
      IconButton(
        onPressed: refresh,
        icon: const Icon(Icons.refresh),
      ),
    ],
  );
}
