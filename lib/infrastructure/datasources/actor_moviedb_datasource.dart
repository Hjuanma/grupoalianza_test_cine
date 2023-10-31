import 'package:dio/dio.dart';
import 'package:grupoalianza_test_cine/config/constants/app_constants.dart';
import 'package:grupoalianza_test_cine/config/constants/environment.dart';
import 'package:grupoalianza_test_cine/config/constants/themoviedb.dart';

import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/movies/actor.dart';
import '../mappers/actor_mapper.dart';
import '../models/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(baseUrl: TheMoviesDB.baseUrl, queryParameters: {
    "api_key": Environment.theMovieDbKey,
    "language": AppConstants.language
  }));
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response =
        await dio.get("${TheMoviesDB.movie}$movieId/${TheMoviesDB.credits}");

    return _jsonToMovie(response.data);
  }

  List<Actor> _jsonToMovie(Map<String, dynamic> json) {
    final castResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors = castResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();
    return actors;
  }
}
