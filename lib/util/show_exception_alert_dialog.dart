import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translatetest/util/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );

String? _message(dynamic exception) {
  if (exception is FirebaseException) {
    return exception.message;
  }
  if (exception is PlatformException) {
    return exception.message;
  }
  return exception.toString();
}
