part of 'movie_info_bloc.dart';

sealed class MovieInfoEvent extends Equatable {
  const MovieInfoEvent();

  @override
  List<Object> get props => [];
}

class MovieInfoFetchEvent extends MovieInfoEvent {
  final Movie movie;
  const MovieInfoFetchEvent(this.movie);

  @override
  List<Object> get props => [movie];
}
