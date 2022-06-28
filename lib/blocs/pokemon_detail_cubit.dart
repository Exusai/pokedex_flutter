import 'package:bloc/bloc.dart';
import 'package:pokedex_flutter/models/pokemon.dart';
import '../models/pokemon_info_response.dart';
import '../models/pokemon_repo.dart';
import '../models/pokemon_species_response.dart';

class PokemonDetailsCubit extends Cubit<Pokemon?> {
  final PokemonRepository pokemonRepository = PokemonRepository();

  PokemonDetailsCubit() : super(null);

  void clearPokemonDetails() => emit(null);

  void getPokemonDetails(int pokemonID) async {
    final responses = await Future.wait([
      pokemonRepository.getPokemonInfo(pokemonID),
      pokemonRepository.getPokemonSpeciesInfo(pokemonID),
    ]);
    final pokemonInfo = responses[0] as PokemonInfo;
    final pokemonSpeciesInfo = responses[1] as PokemonSpeciesInfo;

    Pokemon pokemon = Pokemon(
      id: pokemonInfo.id,
      name: pokemonInfo.name,
      imageUrl: pokemonInfo.imageUrl,
      types: pokemonInfo.types,
      height: pokemonInfo.height,
      weight: pokemonInfo.weight,
      abilities: pokemonInfo.abilities,
      moves: pokemonInfo.moves,
      stats: pokemonInfo.stats,
      description: pokemonSpeciesInfo.description,
    );

    emit(pokemon);
  }
}