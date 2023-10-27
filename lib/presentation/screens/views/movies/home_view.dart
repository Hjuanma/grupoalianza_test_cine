import 'package:flutter/cupertino.dart';
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
                color: colors.secondary,
                child: Column(
                  children: [
                    MoviesHorizontalListView(
                      movies: movies,
                      title: AppConstants.recomended,
                    ),
                    MoviesHorizontalListView(
                      movies: movies,
                      title: AppConstants.recomended,
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

  _CustomSliverAppBar({
    super.key,
  });

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
                    placeholderStyle: const TextStyle(color: Colors.white),
                    placeholder: AppConstants.searcheLabel,
                    prefix: const Padding(
                      padding: EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
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
