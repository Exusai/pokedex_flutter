part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;

  PokemonLoaded({
    required this.pokemonListings,
    required this.canLoadNextPage,
  });
}

class PokemonLoadFailed extends PokemonState {
  final String error;

  PokemonLoadFailed({required this.error});
}

