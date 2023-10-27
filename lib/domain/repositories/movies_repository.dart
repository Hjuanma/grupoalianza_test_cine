import '../entities/movies/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaging({int page = 1});
}
