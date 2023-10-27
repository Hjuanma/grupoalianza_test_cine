part of 'movies_repository_bloc.dart';

class MoviesRepositoryState extends Equatable {
  final List<Movie> movies;
  const MoviesRepositoryState({this.movies = const []});

  MoviesRepositoryState copyWith({List<Movie>? movies}) =>
      MoviesRepositoryState(movies: movies ?? this.movies);

  @override
  List<Object> get props => [];
}
