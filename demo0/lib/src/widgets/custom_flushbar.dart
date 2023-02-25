import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushbar {
  static void showError(
    context, {
    String? title,
    required String message,
  }) {
    Flushbar(
      title: title,
      message: message,
      icon: const Icon(
        Icons.error,
        size: 28.0,
        color: Colors.red,
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
    )..show(context);
  }

  static void showSuccess(
    context, {
    String? title,
    required String message,
  }) =>
      Flushbar(
        title: title,
        message: message,
        icon: Icon(
          Icons.check_circle,
          size: 28.0,
          color: Colors.green,
        ),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
      )..show(context);

  static void showLoading(context) => Flushbar(
        message: "Loading...",
        showProgressIndicator: true,
        flushbarStyle: FlushbarStyle.GROUNDED,
      )..show(context);

  static void close(context) => Navigator.pop(context);
}
