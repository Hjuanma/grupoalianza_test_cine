import 'package:dio/dio.dart';
import 'package:grupoalianza_test_cine/config/constants/environment.dart';
import 'package:grupoalianza_test_cine/config/constants/themoviedb.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';

import '../../domain/datasources/movies_datasource.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(baseUrl: TheMoviesDB.baseUrl, queryParameters: {
    "api_key": Environmet.theMovieDbKey,
    "language": "es-MX"
  }));

  @override
  Future<List<Movie>> getNowPlaging({int page = 1}) async {
    final response =
        await dio.get("${TheMoviesDB.movie}${TheMoviesDB.nowPlaying}");
    final List<Movie> movies = [];
    return movies;
  }
}
