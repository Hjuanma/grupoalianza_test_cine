import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupoalianza_test_cine/domain/entities/movies/actor.dart';
import 'package:grupoalianza_test_cine/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:grupoalianza_test_cine/infrastructure/repositories/actors_repository_impl.dart';

part 'actors_event.dart';
part 'actors_state.dart';

class ActorsBloc extends Bloc<ActorsInfoFetchEvent, ActorsState> {
  final _moviesRepository = ActorsRepositoryImpl(ActorMovieDbDatasource());

  ActorsBloc() : super(const ActorsState()) {
    on<ActorsInfoFetchEvent>(_onActorFetched);
  }
  void _onActorFetched(
      ActorsInfoFetchEvent event, Emitter<ActorsState> emit) async {
    emit(
        state.copyWith(actors: {...state.actors, event.movieId: event.actors}));
  }

  Future<void> fetchActorsByMovie(String movieId) async {
    if (state.actors[movieId] != null) return;

    List<Actor> actors = await _moviesRepository.getActorsByMovie(movieId);

    add(ActorsInfoFetchEvent(actors: actors, movieId: movieId));
  }
}
