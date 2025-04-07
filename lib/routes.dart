import 'package:dinnduh_test/home.dart';
import 'package:dinnduh_test/session.dart';
import 'package:dinnduh_test/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => Splash()),
    GoRoute(path: '/home', builder: (context, state) => Home()),
    GoRoute(
      path: '/session/:id',
      builder: (context, state) {
        final params = state.pathParameters['id'] ?? '';
        return SessionScreen(id: params);
      }, // Replace with your session screen widget
    ),
  ],
);
