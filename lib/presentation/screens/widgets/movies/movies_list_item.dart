import 'package:flutter/material.dart';
import 'package:grupoalianza_test_cine/config/constants/helpers/HumanFormats.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  const MovieListItem({
    super.key,
    required this.movie,
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
          height: 305,
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
        ),
      ],
    );
  }
}
