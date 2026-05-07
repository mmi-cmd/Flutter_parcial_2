import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parcial_2/providers/color_provider.dart';
import 'package:parcial_2/providers/dark_provider.dart';

// Colores con nombre y valor
const _colors = [
  {'label': 'Rojo',     'value': 0, 'color': Colors.red},
  {'label': 'Verde',    'value': 1, 'color': Colors.green},
  {'label': 'Azul',     'value': 2, 'color': Colors.blue},
  {'label': 'Naranja',  'value': 3, 'color': Colors.orange},
  {'label': 'Morado',   'value': 4, 'color': Colors.purple},
];

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final valueDark = ref.watch(darkProvider);
    final valueColor = ref.watch(colorChange);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Apariencia ──────────────────────────────────────────────
          Text('Apariencia', style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          )),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                RadioListTile<int>(
                  value: 0,
                  groupValue: valueDark,
                  title: const Text('Tema claro'),
                  secondary: const Icon(Icons.light_mode_outlined),
                  onChanged: (v) =>
                      ref.read(darkProvider.notifier).state = v!,
                ),
                const Divider(height: 1),
                RadioListTile<int>(
                  value: 1,
                  groupValue: valueDark,
                  title: const Text('Tema oscuro'),
                  secondary: const Icon(Icons.dark_mode_outlined),
                  onChanged: (v) =>
                      ref.read(darkProvider.notifier).state = v!,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Color del tema ──────────────────────────────────────────
          Text('Color del tema', style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          )),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _colors.map((c) {
                  final index = c['value'] as int;
                  final color = c['color'] as Color;
                  final label = c['label'] as String;
                  final isSelected = valueColor == index;

                  return GestureDetector(
                    onTap: () =>
                        ref.read(colorChange.notifier).changeValue(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(
                                    color: theme.colorScheme.onSurface,
                                    width: 3,
                                  )
                                : null,
                            boxShadow: isSelected
                                ? [BoxShadow(
                                    color: color.withValues(alpha: 0.5),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  )]
                                : null,
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(height: 4),
                        Text(label, style: theme.textTheme.labelSmall),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}