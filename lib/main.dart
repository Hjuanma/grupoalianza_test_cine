import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grupoalianza_test_cine/config/router/app_router.dart';
import 'package:grupoalianza_test_cine/config/theme/app_theme.dart';
import 'package:grupoalianza_test_cine/presentation/blocs/movies_repository/movies_repository_bloc.dart';

Future<void> main() async {
  await dotenv.load(
    fileName: ".env",
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => MoviesRepositoryBloc(),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme().copyWith(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      debugShowCheckedModeBanner: false,
    );
  }
}
