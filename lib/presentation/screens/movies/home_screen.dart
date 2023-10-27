import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/movies_repository/movies_repository_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //Se escucha de forma activa el bloc para detectar la actualizacion de las peliculas
    context.read<MoviesRepositoryBloc>().loadMovies();

    final movies = context.watch<MoviesRepositoryBloc>().state.movies;

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(title: Text(movie.title));
      },
    );
  }
}
