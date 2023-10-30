import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grupoalianza_test_cine/config/constants/app_constants.dart';
import 'package:grupoalianza_test_cine/presentation/screens/widgets/movies/movies_list_item.dart';

import '../../../../config/constants/helpers/HumanFormats.dart';
import '../../../../domain/entities/movies/movie.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final VoidCallback? loadNexPAge;
  final String category;
  const MoviesHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.loadNexPAge,
      required this.category});

  @override
  State<MoviesHorizontalListView> createState() =>
      _MoviesHorizontalListViewState();
}

class _MoviesHorizontalListViewState extends State<MoviesHorizontalListView> {
  //Se crea un controlador para detectar la actividad del usuario
  final scrollController = ScrollController();

  //Se detecta el movimiento del usuario en caso de estar cerca del final de la lista de cargan nuevas pelicualas
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNexPAge == null) return;

      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNexPAge!();
      }
    });
  }

  //Se elimina el listener del scroll
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 360,
      child: Column(children: [
        _Title(
          title: widget.title,
          category: widget.category,
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final movie = widget.movies[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    MovieListItem(movie: movie),
                    const Spacer(),

                    //*Popularidad
                    SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_half_outlined,
                            color: Colors.yellow.shade800,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${movie.voteAverage}",
                            style: textStyle.bodyMedium
                                ?.copyWith(color: Colors.yellow.shade800),
                          ),
                          const Spacer(),
                          Text(
                            HumanFormats.number(movie.popularity),
                            style: textStyle.bodySmall,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String category;
  const _Title({this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: textStyle.titleLarge,
            ),
          const Spacer(),
          TextButton(
            onPressed: () => context.push("/categories/$category"),
            child: Text(
              AppConstants.viewAll,
              style: textStyle.bodyLarge,
            ),
          )
        ],
      ),
    );
  }
}
