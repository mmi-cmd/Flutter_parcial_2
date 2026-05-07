import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:parcial_2/config/router/router_config.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  Future<void> _logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    if (!context.mounted) return;
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // ── Encabezado ──────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const NetworkImage(
                        'https://images.unsplash.com/photo-1557682224-5b8590cd9ec5?w=400&fit=crop',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.85),
                        BlendMode.srcOver,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.person,
                          size: 36,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ingeniería de sistemas',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              'José García  - 0192349',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),

                            const Text(
                              'Michell Pérez - 0199999',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                // ── Rutas ───────────────────────────────────────────
                ...routerConfig.map((route) {
                  return ListTile(
                    iconColor: Theme.of(context).colorScheme.primary,
                    title: Text(route.name),
                    subtitle: Text(route.description),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(route.path);
                    },
                  );
                }),
              ],
            ),
          ),

          // ── Botón cerrar sesión al fondo ────────────────────────────
          const Divider(height: 1),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'Cerrar sesión',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
