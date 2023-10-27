import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grupoalianza_test_cine/config/constants/app_constants.dart';
import 'package:grupoalianza_test_cine/config/constants/environment.dart';
import 'package:grupoalianza_test_cine/config/constants/themoviedb.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';
import 'package:grupoalianza_test_cine/infrastructure/mappers/movie_mappers.dart';
import 'package:grupoalianza_test_cine/infrastructure/models/moviedb_response.dart';

import '../../domain/datasources/movies_datasource.dart';

class MoviedbDatasource extends MoviesDatasource {
  //Se crea una instancia de dio para las consultas al servidor.
  final dio = Dio(BaseOptions(baseUrl: TheMoviesDB.baseUrl, queryParameters: {
    "api_key": Environmet.theMovieDbKey,
    "language": AppConstants.language
  }));

  //Se retorna una lista de peliculas mapeada a la entidad local para el manejo de los datos.
  @override
  Future<List<Movie>> getNowPlaging({int page = 1}) async {
    Map<String, dynamic> data;

    //* Se agrega try chat por intermitencias en el servicio
    try {
      final response =
          await dio.get("${TheMoviesDB.movie}${TheMoviesDB.nowPlaying}");
      data = response.data;
    } catch (e) {
      data = jsonDecode(AppConstants.mock) as Map<String, dynamic>;
    }

    final moviedbResponse = MovieDbResponse.fromJson(data);
    final List<Movie> movies = moviedbResponse.results
        .where((element) => element.posterPath != "no-poster")
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();
    return movies;
  }
}
