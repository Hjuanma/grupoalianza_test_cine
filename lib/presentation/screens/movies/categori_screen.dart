import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupoalianza_test_cine/config/constants/enumerables.dart';
import 'package:grupoalianza_test_cine/presentation/screens/views/movies/movie_masonry.dart';

import '../../../config/constants/app_constants.dart';
import '../../../domain/entities/movies/movie.dart';
import '../../blocs/movies_repository/movies_repository_bloc.dart';

class CategoriScreen extends StatefulWidget {
  static const String name = "categori-screen";
  final String categoriId;
  const CategoriScreen({super.key, required this.categoriId});

  @override
  State<CategoriScreen> createState() => _CategoriScreenState();
}

class _CategoriScreenState extends State<CategoriScreen> {
  bool isLoading = false;
  bool isLastPage = false;

  Future<void> loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    var option = Categories.values
        .where((element) => element.value == widget.categoriId)
        .firstOrNull;

    switch (option) {
      case Categories.recomended:
        await context
            .read<MoviesRepositoryBlocPlaying>()
            .loadNowPlagingMovies();

        break;
      case Categories.popular:
        await context.read<MoviesRepositoryBlocPopular>().loadPupularMovies();

        break;
      case Categories.topRate:
        await context.read<MoviesRepositoryBlocTopRate>().loadTopRatedMovies();
        break;
      case Categories.upcoming:
        await context.read<MoviesRepositoryBlocUpcoming>().loadUpcomingMovies();
        break;
      default:
    }

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleLarge;
    List<Movie> movies = [];

    String title = "";

    final option = Categories.values
        .where((element) => element.value == widget.categoriId)
        .firstOrNull;
    switch (option) {
      case Categories.recomended:
        movies = context.watch<MoviesRepositoryBlocPlaying>().state.movies;
        title = AppConstants.recomended;
        break;
      case Categories.popular:
        title = AppConstants.popular;
        movies = context.watch<MoviesRepositoryBlocPopular>().state.movies;

        break;
      case Categories.topRate:
        movies = context.watch<MoviesRepositoryBlocTopRate>().state.movies;
        title = AppConstants.topRated;
        break;
      case Categories.upcoming:
        movies = context.watch<MoviesRepositoryBlocUpcoming>().state.movies;
        title = AppConstants.upcoming;
        break;
      default:
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.background,
        foregroundColor: colors.secondary,
        title: Text(
          title,
          style: textStyle,
        ),
        shadowColor: Colors.transparent,
      ),
      backgroundColor: colors.background,
      body: MovieMasonry(movies: movies, loadNextPage: loadNextPage),
    );
  }
}
