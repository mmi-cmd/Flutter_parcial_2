import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('Buttons'),
            onTap: () => context.goNamed('button'),
          ),
          ListTile(
            title: const Text('Cards'),
            onTap: () => context.goNamed('Card'),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () => context.goNamed('settings'),
          ),
          ListTile(
            title: const Text('Formulario'),
            onTap: () => context.goNamed('Formulario'),
          ),
          ListTile(
            title: const Text('Lista'),
            onTap: () => context.goNamed('Lista'),
          ),
        ],
      ),
    );
  }
}