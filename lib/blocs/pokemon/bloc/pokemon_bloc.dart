import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokedex_flutter/models/pokemon_response.dart';

import '../../../models/pokemon_repo.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonPageRequest>(
      (event, emit) async {
        if (event is PokemonPageRequest){
          emit(PokemonLoading());
          try {
            final PokemonPageResponse pokemonPage = await PokemonRepository().getPokemonPage(event.page);
            //final PokemonPageResponse pokemonPage = await PokemonRepository().getPokemonPage(0);
            emit(PokemonLoaded(
              pokemonListings: pokemonPage.pokemonListings,
              canLoadNextPage: pokemonPage.canLoadNext,
            ));
          } catch (error) {
            emit(PokemonLoadFailed(error: error.toString()));
          }
        }
      }
    );
  }
}
