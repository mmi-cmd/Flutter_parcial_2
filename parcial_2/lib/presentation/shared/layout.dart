import 'package:flutter/material.dart';
import 'package:parcial_2/presentation/drawer_custom.dart';



class Layout extends StatelessWidget {
  final Widget child;
  final String title;
  const Layout({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: DrawerCustom(),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
          Expanded(child: child)
          ]),
      ),
    );
  }
}
