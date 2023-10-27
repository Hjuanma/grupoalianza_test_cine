// repositorio de solo lectura en toda la app
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';

import '../../domain/datasources/movies_datasource.dart';
import '../../domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MoviesRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaging({int page = 1}) {
    return datasource.getNowPlaging(page: page);
  }
}
