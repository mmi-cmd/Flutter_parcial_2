import 'package:flutter/foundation.dart';
import 'package:parcial_2/config/router/router_model.dart';
import 'package:parcial_2/presentation/screen/home/home.dart';
import 'package:parcial_2/presentation/screen/products/product_form_screen.dart';
import 'package:parcial_2/presentation/screen/products/products_screen.dart';
import 'package:parcial_2/presentation/screen/user/user_screen.dart';


List<RouterModel> routerConfig = [

  RouterModel(
    name: 'Home',
    title: 'Home',
    description: 'Pantalla de inicio',
    path: '/home',
    widget: (context, state) => const Home(),
  ),

  RouterModel(
    name: 'Users',
    title: 'Users',
    description: 'Perfil del usuario autenticado',
    path: '/users',
    widget: (context, state) => const UserScreen(),
  ),

  RouterModel(
  name: 'Products',
  title: 'Products',
  description: 'Lista de productos',
  path: '/products',
  widget: (context, state) => ProductsScreen(key: ValueKey(DateTime.now().millisecondsSinceEpoch)),
),

  RouterModel(
    name: 'ProductForm',
    title: 'Nuevo Producto',
    description: 'Crear un nuevo producto',
    path: '/product-form',
    widget: (context, state) => const ProductFormScreen(),
  ),

];