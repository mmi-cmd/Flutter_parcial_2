import 'package:flutter/material.dart';
import 'package:parcial_2/presentation/screen/products/product_form_screen.dart';
import 'package:parcial_2/presentation/screen/products/products_screen.dart';


class ProductsTabScreen extends StatelessWidget {
  const ProductsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.list_alt_outlined), text: 'Registered'),
              Tab(icon: Icon(Icons.add_box_outlined), text: 'Products'),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                ProductFormScreen(),
                ProductsScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}