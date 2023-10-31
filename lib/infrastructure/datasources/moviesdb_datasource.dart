import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grupoalianza_test_cine/config/constants/app_constants.dart';
import 'package:grupoalianza_test_cine/config/constants/environment.dart';
import 'package:grupoalianza_test_cine/config/constants/themoviedb.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';
import 'package:grupoalianza_test_cine/infrastructure/mappers/movie_mappers.dart';
import 'package:grupoalianza_test_cine/infrastructure/models/moviedb_response.dart';

import '../../domain/datasources/movies_datasource.dart';
import '../models/moviedb_details.dart';

class MoviedbDatasource extends MoviesDatasource {
  //* Se crea una instancia de dio para las consultas al servidor.
  final dio = Dio(
    BaseOptions(
      baseUrl: TheMoviesDB.baseUrl,
      queryParameters: {
        "api_key": Environment.theMovieDbKey,
        "language": AppConstants.language
      },
    ),
  );

  //* Se mapea el json obtenido de la consulta
  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((movieDb) => movieDb.posterPath != "no-poster")
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();
    return movies;
  }

  //*Se retorna una lista de peliculas mapeada a la entidad local para el manejo de los datos.
  @override
  Future<List<Movie>> getNowPlaging({int page = 1}) async {
    Map<String, dynamic> data;

    //* Se agrega try chat por intermitencias en el servicio
    try {
      final response = await dio.get(
          "${TheMoviesDB.movie}${TheMoviesDB.nowPlaying}",
          queryParameters: {"page": page});
      data = response.data;
    } catch (e) {
      data = jsonDecode(AppConstants.mock) as Map<String, dynamic>;
    }
    return _jsonToMovie(data);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    Map<String, dynamic> data;

    //* Se agrega try chat por intermitencias en el servicio
    try {
      final response = await dio.get(
        "${TheMoviesDB.movie}${TheMoviesDB.popular}",
        queryParameters: {"page": page},
      );
      data = response.data;
    } catch (e) {
      data = jsonDecode(AppConstants.mock) as Map<String, dynamic>;
    }
    return _jsonToMovie(data);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    Map<String, dynamic> data;

    //* Se agrega try chat por intermitencias en el servicio
    try {
      final response = await dio.get(
          "${TheMoviesDB.movie}${TheMoviesDB.topRated}",
          queryParameters: {"page": page});
      data = response.data;
    } catch (e) {
      data = jsonDecode(AppConstants.mock) as Map<String, dynamic>;
    }
    return _jsonToMovie(data);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    Map<String, dynamic> data;

    //* Se agrega try chat por intermitencias en el servicio
    try {
      final response = await dio.get(
          "${TheMoviesDB.movie}${TheMoviesDB.upcoming}",
          queryParameters: {"page": page});
      data = response.data;
    } catch (e) {
      data = jsonDecode(AppConstants.mock) as Map<String, dynamic>;
    }
    return _jsonToMovie(data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get("${TheMoviesDB.movie}$id");

    if (response.statusCode != 200)
      throw Exception("Movie with id: $id not found");

    final movieDB = MovieDbDetails.fromJson(response.data);

    final movie = MovieMapper.movieDbDetailsToEntity(movieDB);

    return movie;
  }
}
