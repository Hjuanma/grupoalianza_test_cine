import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/constants/enumerables.dart';
import '../../../blocs/movies_repository/movies_repository_bloc.dart';
import '../../widgets/movies/movies_horizontal_listview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    //Se escucha de forma activa el bloc para detectar la actualizacion de las peliculas
    context.read<MoviesRepositoryBlocPlaying>().loadNowPlagingMovies();
    context.read<MoviesRepositoryBlocPopular>().loadPupularMovies();
    context.read<MoviesRepositoryBlocTopRate>().loadTopRatedMovies();
    context.read<MoviesRepositoryBlocUpcoming>().loadUpcomingMovies();
  }

  Future<void> loadNextPage(Categories category) async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    switch (category) {
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
    final recomendedMovies =
        context.watch<MoviesRepositoryBlocPopular>().state.movies;
    final topRatedMovies =
        context.watch<MoviesRepositoryBlocPopular>().state.movies;
    final popularMovies =
        context.watch<MoviesRepositoryBlocPopular>().state.movies;
    final upcomingMovies =
        context.watch<MoviesRepositoryBlocUpcoming>().state.movies;

    final colors = Theme.of(context).colorScheme;
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            color: colors.primary,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: colors.background,
                child: Column(
                  children: [
                    MoviesHorizontalListView(
                      movies: recomendedMovies,
                      title: AppConstants.recomended,
                      loadNexPAge: () async =>
                          await loadNextPage(Categories.recomended),
                      category: Categories.recomended.value,
                    ),
                    MoviesHorizontalListView(
                      movies: topRatedMovies,
                      title: AppConstants.topRated,
                      loadNexPAge: () async =>
                          await loadNextPage(Categories.topRate),
                      category: Categories.topRate.value,
                    ),
                    MoviesHorizontalListView(
                      movies: popularMovies,
                      title: AppConstants.popular,
                      loadNexPAge: () async =>
                          await loadNextPage(Categories.popular),
                      category: Categories.popular.value,
                    ),
                    MoviesHorizontalListView(
                      movies: upcomingMovies,
                      title: AppConstants.upcoming,
                      loadNexPAge: () async =>
                          await loadNextPage(Categories.upcoming),
                      category: Categories.upcoming.value,
                    ),
                  ],
                ),
              ),
            ),
          );
        }, childCount: 1))
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final TextEditingController _filter = TextEditingController();

  _CustomSliverAppBar();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      backgroundColor: colors.primary,
      expandedHeight: size.height * 0.25,
      collapsedHeight: size.height * 0.1,
      foregroundColor: Colors.white,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          double appBarHeight =
              constraints.biggest.height; //getting AppBar height
          bool isExpanded =
              appBarHeight > size.height * 0.25; //check if AppBar is expanded
          return FlexibleSpaceBar(
            titlePadding:
                const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            centerTitle: true,
            title: SizedBox(
              height: size.height * 0.15,
              child: Column(
                mainAxisAlignment: isExpanded
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.end,
                children: [
                  const Text(AppConstants.searcheTitle),
                  const SizedBox(
                    height: 4,
                  ),
                  CupertinoTextField(
                    controller: _filter,
                    keyboardType: TextInputType.text,
                    placeholderStyle: TextStyle(color: colors.secondary),
                    placeholder: AppConstants.searcheLabel,
                    prefix: Padding(
                      padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                      child: Icon(
                        Icons.search,
                        color: colors.secondary,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: colors.primaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
