import 'package:go_router/go_router.dart';
import 'package:grupoalianza_test_cine/presentation/screens/movies/categori_screen.dart';
import 'package:grupoalianza_test_cine/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: "categories/:id",
          name: CategoriScreen.name,
          builder: (context, state) {
            return CategoriScreen(
                categoriId: state.pathParameters["id"] ?? "no-id");
          },
        )
      ],
    ),
  ],
);
