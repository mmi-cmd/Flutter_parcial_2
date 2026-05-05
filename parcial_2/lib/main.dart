import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parcial_2/config/router/router.dart';
import 'package:parcial_2/config/theme/app_theme.dart';
import 'package:parcial_2/providers/color_provider.dart';
import 'package:parcial_2/providers/dark_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Widgets',
      theme: AppTheme(
        selectColor: ref.watch(colorChange),
      ).themeData(ref.watch(darkProvider)),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
