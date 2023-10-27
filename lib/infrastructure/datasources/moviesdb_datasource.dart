import 'package:dio/dio.dart';
import 'package:grupoalianza_test_cine/config/constants/environment.dart';
import 'package:grupoalianza_test_cine/config/constants/themoviedb.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';
import 'package:grupoalianza_test_cine/infrastructure/mappers/movie_mappers.dart';
import 'package:grupoalianza_test_cine/infrastructure/models/moviedb_response.dart';

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

    final moviedbResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = moviedbResponse.results
        .where((element) => element.posterPath != "no-poster")
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();
    return movies;
  }
}
