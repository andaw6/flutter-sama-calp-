
import 'package:flutter/material.dart';

void dialog({required BuildContext context, dynamic content = const Text("Dialog"), Color? background}){
  background ??= Colors.blue.shade500;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: content,
      backgroundColor: background,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}