import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';
import 'package:grupoalianza_test_cine/infrastructure/repositories/movies_repository_impl.dart';

import '../../../infrastructure/datasources/moviesdb_datasource.dart';

part 'movies_repository_event.dart';
part 'movies_repository_state.dart';

class MoviesRepositoryBloc
    extends Bloc<MoviesRepositoryEvent, MoviesRepositoryState> {
  final _moviesRepository = MoviesRepositoryImpl(MoviedbDatasource());

  int page = 0;

  MoviesRepositoryBloc() : super(const MoviesRepositoryState()) {
    on<MoviesRepositoryUpdated>(_onMoviesLoaded);
  }

//Se consultan las peliculas por pagina en endpoint
  Future<void> loadMovies() async {
    List<Movie> movies = await _moviesRepository.getNowPlaging();

    add(MoviesRepositoryUpdated(movies));

    page++;
  }

//Se agregan las nuevas peliculas al state
  void _onMoviesLoaded(
      MoviesRepositoryUpdated event, Emitter<MoviesRepositoryState> emit) {
    emit(state.copyWith(movies: [...state.movies, ...event.moviesList]));
  }
}
