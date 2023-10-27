import '../entities/movies/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getNowPlaging({int page = 1});
}
