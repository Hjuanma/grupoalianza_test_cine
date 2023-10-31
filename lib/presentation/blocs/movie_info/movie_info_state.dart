part of 'movie_info_bloc.dart';

class MovieInfoState extends Equatable {
  final Map<String, Movie> movies;
  const MovieInfoState({this.movies = const {}});

  MovieInfoState copyWith({Map<String, Movie>? movies}) =>
      MovieInfoState(movies: movies ?? this.movies);

  @override
  List<Object> get props => [movies];
}
