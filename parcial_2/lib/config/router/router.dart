import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:parcial_2/config/router/router_config.dart';
import 'package:parcial_2/presentation/auth/auth.dart';
import 'package:parcial_2/presentation/screen/home/home.dart';
import 'package:parcial_2/presentation/shared/layout.dart';


final storage  = FlutterSecureStorage();

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final token = await storage.read(key: 'token');
    final isLoadingRoute  =  state.matchedLocation == '/';
    if (token == null && !isLoadingRoute) {
      return isLoadingRoute ? null : '/';
    }

    if (token != null && token.isNotEmpty && isLoadingRoute) {
      return '/home';
    }

  },

  routes: <RouteBase>[
    GoRoute( // Ruta de login, va fuera del ShellRoute para no mostrar el layout
      path: '/',
      name: 'Login',
      builder: (context, state) => const Auth(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        String? data = state.topRoute?.name ?? 'Administrador';
        return Layout(title: data, child: child);
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
  errorBuilder: (context, state) => const Home(),
);