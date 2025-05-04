import 'package:flutter/material.dart';

void snackBarMassage(BuildContext context, String massage,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      massage,
      style: const TextStyle(fontSize: 14, color: Colors.white),
    ),
    backgroundColor: isError ? Colors.red : null,
  ));
}
