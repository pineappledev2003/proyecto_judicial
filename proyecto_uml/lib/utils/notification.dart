import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Notificacion {
  static void mostrar(String message, {bool isError = false}) {
    showToast(
      message,
      duration: Duration(seconds: 3),
      position: ToastPosition.bottom,
      backgroundColor: isError ? Colors.red : Colors.green,
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      radius: 8.0,
    );
  }

}
