part of 'movies_repository_bloc.dart';

sealed class MoviesRepositoryEvent extends Equatable {
  final List<Movie> moviesList;
  const MoviesRepositoryEvent({required this.moviesList});

  @override
  List<Object> get props => [];
}

class MoviesRepositoryNowPlayingUpdated extends MoviesRepositoryEvent {
  const MoviesRepositoryNowPlayingUpdated({required super.moviesList});
}

class MoviesRepositoryPopularUpdated extends MoviesRepositoryEvent {
  const MoviesRepositoryPopularUpdated({required super.moviesList});
}

class MoviesRepositoryTopRatedUpdated extends MoviesRepositoryEvent {
  const MoviesRepositoryTopRatedUpdated({required super.moviesList});
}

class MoviesRepositoryUpcomingUpdated extends MoviesRepositoryEvent {
  const MoviesRepositoryUpcomingUpdated({required super.moviesList});
}
