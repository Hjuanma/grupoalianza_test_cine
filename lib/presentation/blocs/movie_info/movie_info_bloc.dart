import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/movie.dart';
import 'package:grupoalianza_test_cine/infrastructure/datasources/moviesdb_datasource.dart';
import 'package:grupoalianza_test_cine/infrastructure/repositories/movies_repository_impl.dart';

part 'movie_info_event.dart';
part 'movie_info_state.dart';

class MovieInfoBloc extends Bloc<MovieInfoFetchEvent, MovieInfoState> {
  final _moviesRepository = MoviesRepositoryImpl(MoviedbDatasource());

  MovieInfoBloc() : super(const MovieInfoState()) {
    on<MovieInfoFetchEvent>(_onMovieFetched);
  }

  void _onMovieFetched(
      MovieInfoFetchEvent event, Emitter<MovieInfoState> emit) async {
    emit(state.copyWith(
        movies: {...state.movies, event.movie.id.toString(): event.movie}));
  }

  Future<void> fetchMovie(String movieId) async {
    if (state.movies[movieId] != null) return;

    Movie movie = await _moviesRepository.getMovieById(movieId);

    add(MovieInfoFetchEvent(movie));
  }
}
