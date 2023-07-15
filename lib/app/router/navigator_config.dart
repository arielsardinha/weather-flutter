import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

sealed class CustonNavigator {
  static Future<T?> pushNamed<T>(BuildContext context, String routerName,
      {arguments}) async {
    return context.push(
      routerName,
      extra: arguments,
    );
  }
}
