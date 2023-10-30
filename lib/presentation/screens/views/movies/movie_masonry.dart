import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../domain/entities/movies/movie.dart';
import '../../widgets/movies/movies_list_item.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (widget.loadNextPage == null) return;

      if (controller.position.pixels + 100 >=
          controller.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Expanded(
        child: MasonryGridView.count(
          controller: controller,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: widget.movies.length,
          itemBuilder: (context, index) {
            if (index == 1) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  MovieListItem(
                    movie: widget.movies[index],
                  ),
                ],
              );
            }

            return MovieListItem(
              movie: widget.movies[index],
            );
          },
        ),
      ),
    );
  }
}
