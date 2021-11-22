import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odeon/window_size/window_size.dart';

import 'app.dart';

void main() {
  init();
}

void init() async {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowProperties();
  runApp(const ProviderScope(child: App()));
}
