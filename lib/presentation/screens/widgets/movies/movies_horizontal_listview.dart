import 'package:flutter/material.dart';
import 'package:grupoalianza_test_cine/config/constants/app_constants.dart';
import 'package:grupoalianza_test_cine/presentation/screens/widgets/movies/movies_list_item.dart';

import '../../../../domain/entities/movies/movie.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final VoidCallback? loadNexPAge;
  const MoviesHorizontalListView(
      {super.key, required this.movies, this.title, this.loadNexPAge});

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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 370,
      child: Column(children: [
        _Title(title: widget.title),
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
                child: MovieListItem(movie: movie),
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
  const _Title({this.title});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;

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
              style: textStyle,
            ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              AppConstants.viewAll,
            ),
          )
        ],
      ),
    );
  }
}
