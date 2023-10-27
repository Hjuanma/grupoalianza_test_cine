import '../entities/movies/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaging({int page = 1});
}
