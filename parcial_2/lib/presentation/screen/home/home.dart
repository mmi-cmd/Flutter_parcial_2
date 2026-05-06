import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parcial_2/config/router/router_config.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...routerConfig.map((route) {
          return ListTile(
            title: Text(route.name),
            subtitle: Text(route.description),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () => context.go(route.path),
          );
        }),
      ],
    );
  }
}