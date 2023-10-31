part of 'actors_bloc.dart';

sealed class ActorsEvent extends Equatable {
  const ActorsEvent();

  @override
  List<Object> get props => [];
}

class ActorsInfoFetchEvent extends ActorsEvent {
  final List<Actor> actors;
  final String movieId;
  const ActorsInfoFetchEvent({required this.actors, required this.movieId});

  @override
  List<Object> get props => [actors, movieId];
}
