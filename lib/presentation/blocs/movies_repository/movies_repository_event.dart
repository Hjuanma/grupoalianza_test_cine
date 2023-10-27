part of 'movies_repository_bloc.dart';

sealed class MoviesRepositoryEvent extends Equatable {
  const MoviesRepositoryEvent();

  @override
  List<Object> get props => [];
}

class MoviesRepositoryUpdated extends MoviesRepositoryEvent {
  final List<Movie> moviesList;

  const MoviesRepositoryUpdated(this.moviesList);
}
