import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:parcial_2/config/router/router_config.dart';
import 'package:parcial_2/presentation/auth/auth.dart';
import 'package:parcial_2/presentation/screen/products/product_detail_screen.dart';
import 'package:parcial_2/presentation/shared/layout.dart';

final _storage = FlutterSecureStorage();

final GoRouter router = GoRouter(
  initialLocation: '/',
  // ── Guard global — protege todas las rutas excepto '/' ──────────────────
  redirect: (context, state) async {
    final token = await _storage.read(key: 'token');
    final isPublic = state.matchedLocation == '/';

    // Sin token fuera del login → al login
    if (token == null && !isPublic) return '/';

    // Con token en el login → al home
    if (token != null && token.isNotEmpty && isPublic) return '/home';

    return null; // deja pasar
  },

  routes: [
    // Ruta pública — login
    GoRoute(
      path: '/',
      name: 'Login',
      builder: (context, state) => const Auth(),
    ),

    GoRoute(
          path: '/products/:id',
          name: 'ProductDetail',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return ProductDetailScreen(id: id);
          },
        ),

    // Rutas protegidas dentro del ShellRoute (tienen layout + drawer)
    ShellRoute(
      builder: (context, state, child) {
        final title = state.topRoute?.name ?? 'App';
        return Layout(title: title, child: child);
      },
      routes: [
        ...routerConfig.map((route) => GoRoute(
          path: route.path,
          name: route.name,
          builder: route.widget,
        )),

      ],
    ),
  ],

  errorBuilder: (context, state) => const Auth(),
);