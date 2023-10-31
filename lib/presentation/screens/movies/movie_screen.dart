import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';
import 'package:grupoalianza_test_cine/presentation/blocs/blocs.dart';

import '../widgets/movies/shared/expanded_widget.dart';

class MovieScreen extends StatefulWidget {
  static const name = "movie-screen";
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();

    context.read<MovieInfoBloc>().fetchMovie(widget.movieId);
    context.read<ActorsBloc>().fetchActorsByMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie =
        context.watch<MovieInfoBloc>().state.movies[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetail(movie: movie),
                  childCount: 1)),
        ],
      ),
    );
  }
}

class _MovieDetail extends StatelessWidget {
  final Movie movie;
  const _MovieDetail({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 8,
          ),
          ExpandedWidget(
            text: movie.overview,
          ),
          _ActorsByMovie(
            movieId: movie.id,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              children: [
                const Text(
                  "Genero",
                ),
                ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(left: 10, top: 4),
                    child: Text(
                      gender,
                      style: const TextStyle(fontSize: 10),
                    )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              children: [
                const Text(
                  "Lanzamiento",
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(movie.releaseDate.year.toString())
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorsByMovie extends StatelessWidget {
  final int movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context) {
    final actorsByMovie = context.watch<ActorsBloc>().state.actors;

    if (actorsByMovie[movieId.toString()] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    final actors = actorsByMovie[movieId.toString()]!;

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 170,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      actor.profilePath,
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    actor.name,
                    maxLines: 2,
                  ),
                  Text(
                    actor.character ?? "",
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ]),
          );
        },
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.6,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(children: [
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) return const SizedBox();
                return child;
              },
            ),
          ),
        ]),
      ),
    );
  }
}
