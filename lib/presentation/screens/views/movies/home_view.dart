import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../blocs/movies_repository/movies_repository_bloc.dart';
import '../../widgets/movies/movies_horizontal_listview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    //Se escucha de forma activa el bloc para detectar la actualizacion de las peliculas
    context.read<MoviesRepositoryBloc>().loadMovies();

    final movies = context.watch<MoviesRepositoryBloc>().state.movies;

    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesHorizontalListView(
                movies: movies,
                title: AppConstants.recomended,
              )
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
