import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parcial_2/providers/color_provider.dart';
import 'package:parcial_2/providers/dark_provider.dart';




class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    int valueDark = ref.watch(darkProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Settings screen")),
      body: SafeArea(
        child: Column(
          children: [
            RadioListTile<int>(
              value: 0,
              groupValue: valueDark,
              title: Text('Theme Claro'),
              onChanged: (value) {
                ref.read(darkProvider.notifier).state = value!;
              },
            ),
            RadioListTile<int>(
              value: 1,
              groupValue: valueDark,
              title: Text('Theme oscuro'),
              onChanged: (value) {
                ref.read(darkProvider.notifier).state = value!;
              },
            ),
            RadioGroup(
              onChanged: (value) {} , 
              child: Column(
                children: [
                  ListTile(
                    title: Text("Color numero 1"),
                    onTap: () {ref.read(colorChange.notifier).changeValue(0);},
                  ),
                  ListTile(
                    title: Text("Color numero 2"),
                    onTap: () {ref.read(colorChange.notifier).changeValue(1);},
                  ),
                  ListTile(
                    title: Text("Color numero 3"),
                    onTap: () {ref.read(colorChange.notifier).changeValue(2);},
                  ),
                  ListTile(
                    title: Text("Color numero 4"),
                    onTap: () {ref.read(colorChange.notifier).changeValue(3);},
                  ),
                  ListTile(
                    title: Text("Color numero 5"),
                    onTap: () {ref.read(colorChange.notifier).changeValue(4);},
                  ),

                ],
            )),
          ],
        ),
      ),
    );
  }
}
