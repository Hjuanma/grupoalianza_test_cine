import '../../config/constants/themoviedb.dart';
import '../../domain/entities/movies/movie.dart';
import '../models/models.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb movieDb) => Movie(
      adult: movieDb.adult,
      backdropPath: (movieDb.backdropPath != '')
          ? '${TheMoviesDB.baseImageUrl}${movieDb.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: (movieDb.posterPath != '')
          ? '${TheMoviesDB.baseImageUrl}${movieDb.posterPath}'
          : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount);
}
