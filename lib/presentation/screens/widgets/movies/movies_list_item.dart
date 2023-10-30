import 'package:flutter/material.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final bool? fromHome;
  const MovieListItem({
    super.key,
    required this.movie,
    this.fromHome = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Image
        SizedBox(
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.network(
                      movie.posterPath,
                      fit: BoxFit.cover,
                      width: 150,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {},
                          child: child,
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              //*Titulo
              Text(
                movie.title,
                maxLines: 2,
                style: textStyle.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
