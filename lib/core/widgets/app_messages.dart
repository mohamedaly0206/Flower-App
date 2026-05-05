import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppMessages {
  AppMessages._();

  static void showSuccess(
    BuildContext context, {
    required String message,
    Icon? icon,
  }) {
    _showCustomToast(
      context: context,
      message: message,
      type: ToastificationType.success,
      icon: icon,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Icon? icon,
  }) {
    _showCustomToast(
      context: context,
      message: message,
      type: ToastificationType.error,
      icon: icon,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Icon? icon,
  }) {
    _showCustomToast(
      context: context,
      message: message,
      type: ToastificationType.warning,
      icon: icon,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    Icon? icon,
  }) {
    _showCustomToast(
      context: context,
      message: message,
      type: ToastificationType.info,
      color: Theme.of(context).colorScheme.primary,
      icon: icon,
    );
  }

  static void _showCustomToast({
    required BuildContext context,
    required String message,
    required ToastificationType type,
    Color? color,
    Icon? icon,
  }) {
    toastification.dismissAll();

    toastification.show(
      context: context,
      icon: icon,
      type: type,
      primaryColor: color,
      style: ToastificationStyle.flat,
      title: Text(message),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 500),
      animationBuilder: (context, animation, alignment, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
