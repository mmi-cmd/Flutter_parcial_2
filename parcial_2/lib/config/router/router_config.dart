
import 'package:parcial_2/config/router/router_model.dart';
import 'package:parcial_2/presentation/screen/home/home.dart';
import 'package:parcial_2/presentation/screen/products/products_tab_screen.dart';
import 'package:parcial_2/presentation/screen/settings/settings_screen.dart';
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
    description: 'Lista y registro de productos',
    path: '/products',
    widget: (context, state) => const ProductsTabScreen(),
  ),
  RouterModel(
    name: 'Settings',
    title: 'Settings',
    description: 'Configuración de la cuenta',
    path: '/settings',
    widget: (context, state) => const SettingsScreen(),
  ),
];