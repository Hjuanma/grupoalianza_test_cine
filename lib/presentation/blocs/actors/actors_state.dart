part of 'actors_bloc.dart';

class ActorsState extends Equatable {
  final Map<String, List<Actor>> actors;

  const ActorsState({this.actors = const {}});

  ActorsState copyWith({Map<String, List<Actor>>? actors}) =>
      ActorsState(actors: actors ?? this.actors);

  @override
  List<Object> get props => [actors];
}
