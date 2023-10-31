import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grupoalianza_test_cine/config/router/app_router.dart';
import 'package:grupoalianza_test_cine/config/theme/app_theme.dart';
import 'package:grupoalianza_test_cine/presentation/blocs/blocs.dart';

Future<void> main() async {
  await dotenv.load(
    fileName: ".env",
  );
  //* Se inicializan los providers que se van a usar a lo largo de la aplicacion
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => MoviesRepositoryBlocPlaying(),
      ),
      BlocProvider(
        create: (context) => MoviesRepositoryBlocPopular(),
      ),
      BlocProvider(
        create: (context) => MoviesRepositoryBlocTopRate(),
      ),
      BlocProvider(
        create: (context) => MoviesRepositoryBlocUpcoming(),
      ),
      BlocProvider(
        create: (context) => MovieInfoBloc(),
      ),
      BlocProvider(
        create: (context) => ActorsBloc(),
      ),
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
      themeMode: ThemeMode.system,
      theme: AppTheme().getTheme().copyWith(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: const Color(0xFF2B3848),
                displayColor: const Color(0xFF2B3848),
              )),
      darkTheme: AppTheme().getThemeDarck().copyWith(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      debugShowCheckedModeBanner: false,
    );
  }
}
