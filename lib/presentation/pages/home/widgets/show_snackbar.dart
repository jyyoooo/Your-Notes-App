import 'package:flutter/material.dart';

void showSnackbar(String message, context, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 980),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: color ?? Colors.teal,
      margin: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
    ),
  );
}
