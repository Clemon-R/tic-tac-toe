import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/ui/app/views/app_view.dart';

void main() {
  runApp(ProviderScope(child: const AppView()));
}
