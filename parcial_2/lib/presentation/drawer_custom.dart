import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parcial_2/config/router/router_config.dart';


class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ...routerConfig.map((route) {
            return ListTile(
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
    );
  }
}
