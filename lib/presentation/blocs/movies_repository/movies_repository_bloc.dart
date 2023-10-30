import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';
import 'package:grupoalianza_test_cine/infrastructure/repositories/movies_repository_impl.dart';

import '../../../infrastructure/datasources/moviesdb_datasource.dart';

part 'movies_repository_event.dart';
part 'movies_repository_state.dart';

class MoviesRepositoryBlocPlaying
    extends Bloc<MoviesRepositoryEvent, MoviesRepositoryState> {
  final _moviesRepository = MoviesRepositoryImpl(MoviedbDatasource());

  int page = 0;

  MoviesRepositoryBlocPlaying()
      : super(const NowPlayingMoviesRepositoryState()) {
    on<MoviesRepositoryNowPlayingUpdated>(_onMoviesLoaded);
  }

  //* Se consultan las peliculas por pagina en endpoint
  Future<void> loadNowPlagingMovies() async {
    List<Movie> movies = await _moviesRepository.getNowPlaging();

    add(MoviesRepositoryNowPlayingUpdated(moviesList: movies));

    page++;
  }

//* Se agregan las nuevas peliculas al state
  void _onMoviesLoaded(
      MoviesRepositoryEvent event, Emitter<MoviesRepositoryState> emit) {
    emit(state.copyWith(movies: [...state.movies, ...event.moviesList]));
  }
}

class MoviesRepositoryBlocPopular
    extends Bloc<MoviesRepositoryEvent, MoviesRepositoryState> {
  final _moviesRepository = MoviesRepositoryImpl(MoviedbDatasource());

  int page = 0;

  MoviesRepositoryBlocPopular() : super(const PopularMoviesRepositoryState()) {
    on<MoviesRepositoryPopularUpdated>(_onMoviesLoaded);
  }

  //* Se consultan las peliculas por pagina en endpoint
  Future<void> loadPupularMovies() async {
    List<Movie> movies = await _moviesRepository.getPopularMovies();

    add(MoviesRepositoryPopularUpdated(moviesList: movies));

    page++;
  }

//* Se agregan las nuevas peliculas al state
  void _onMoviesLoaded(
      MoviesRepositoryEvent event, Emitter<MoviesRepositoryState> emit) {
    emit(state.copyWith(movies: [...state.movies, ...event.moviesList]));
  }
}

class MoviesRepositoryBlocTopRate
    extends Bloc<MoviesRepositoryEvent, MoviesRepositoryState> {
  final _moviesRepository = MoviesRepositoryImpl(MoviedbDatasource());

  int page = 0;

  MoviesRepositoryBlocTopRate() : super(const TopRatedMoviesRepositoryState()) {
    on<MoviesRepositoryTopRatedUpdated>(_onMoviesLoaded);
  }

  //* Se consultan las peliculas por pagina en endpoint
  Future<void> loadTopRatedMovies() async {
    List<Movie> movies = await _moviesRepository.getTopRatedMovies();

    add(MoviesRepositoryTopRatedUpdated(moviesList: movies));

    page++;
  }

//* Se agregan las nuevas peliculas al state
  void _onMoviesLoaded(
      MoviesRepositoryEvent event, Emitter<MoviesRepositoryState> emit) {
    emit(state.copyWith(movies: [...state.movies, ...event.moviesList]));
  }
}

class MoviesRepositoryBlocUpcoming
    extends Bloc<MoviesRepositoryEvent, MoviesRepositoryState> {
  final _moviesRepository = MoviesRepositoryImpl(MoviedbDatasource());

  int page = 0;

  MoviesRepositoryBlocUpcoming()
      : super(const UpcomingMoviesRepositoryState()) {
    on<MoviesRepositoryUpcomingUpdated>(_onMoviesLoaded);
  }

//* Se consultan las peliculas por pagina en endpoint
  Future<void> loadUpcomingMovies() async {
    List<Movie> movies = await _moviesRepository.getUpcomingMovies();

    add(MoviesRepositoryUpcomingUpdated(moviesList: movies));

    page++;
  }

  //* Se agregan las nuevas peliculas al state
  void _onMoviesLoaded(
      MoviesRepositoryEvent event, Emitter<MoviesRepositoryState> emit) {
    emit(state.copyWith(movies: [...state.movies, ...event.moviesList]));
  }
}
