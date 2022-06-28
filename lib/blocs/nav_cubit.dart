import 'package:bloc/bloc.dart';
import 'package:pokedex_flutter/blocs/pokemon_detail_cubit.dart';

class PokemonImageIdName {
  final String imageUrl;
  final String name;
  final int id;
  PokemonImageIdName(this.imageUrl, this.name, this.id);
}

class NavCubit extends Cubit<PokemonImageIdName?> {
  PokemonDetailsCubit pokemonDetailsCubit;

  NavCubit({required this.pokemonDetailsCubit}) : super(null);

  void showPokemonDetails(int pokemonID, String pokemonName, String pokemonImageUrl) {
    pokemonDetailsCubit.getPokemonDetails(pokemonID);
    emit(PokemonImageIdName(pokemonImageUrl, pokemonName, pokemonID));
  }

  void popToPokedex() {
    emit(null);
    pokemonDetailsCubit.clearPokemonDetails();
  }
}