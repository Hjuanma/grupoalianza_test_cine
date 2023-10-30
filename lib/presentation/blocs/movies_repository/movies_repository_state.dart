part of 'movies_repository_bloc.dart';

sealed class MoviesRepositoryState extends Equatable {
  final List<Movie> movies;
  const MoviesRepositoryState({this.movies = const []});
  MoviesRepositoryState copyWith({List<Movie>? movies});
  @override
  List<Object> get props => [];
}

final class NowPlayingMoviesRepositoryState extends MoviesRepositoryState {
  const NowPlayingMoviesRepositoryState({super.movies = const []});

  @override
  NowPlayingMoviesRepositoryState copyWith({List<Movie>? movies}) =>
      NowPlayingMoviesRepositoryState(movies: movies ?? super.movies);
}

final class PopularMoviesRepositoryState extends MoviesRepositoryState {
  const PopularMoviesRepositoryState({super.movies = const []});

  @override
  PopularMoviesRepositoryState copyWith({List<Movie>? movies}) =>
      PopularMoviesRepositoryState(movies: movies ?? super.movies);
}

final class TopRatedMoviesRepositoryState extends MoviesRepositoryState {
  const TopRatedMoviesRepositoryState({super.movies = const []});

  @override
  TopRatedMoviesRepositoryState copyWith({List<Movie>? movies}) =>
      TopRatedMoviesRepositoryState(movies: movies ?? super.movies);
}

final class UpcomingMoviesRepositoryState extends MoviesRepositoryState {
  const UpcomingMoviesRepositoryState({super.movies = const []});

  @override
  UpcomingMoviesRepositoryState copyWith({List<Movie>? movies}) =>
      UpcomingMoviesRepositoryState(movies: movies ?? super.movies);
}
