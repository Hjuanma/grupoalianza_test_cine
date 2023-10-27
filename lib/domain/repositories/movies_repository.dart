import '../entities/movies/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaging({int page = 1});
}
