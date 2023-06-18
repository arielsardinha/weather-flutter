import 'dart:async';

import 'package:flutter/material.dart';

mixin DebouncerMixin {
  Timer? _debounce;

  void debounce(VoidCallback function, {bool cancel = false}) {
    if (cancel) {
      _debounce!.cancel();
      return;
    }
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 2), function);
  }
}
