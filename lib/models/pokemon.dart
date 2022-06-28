import 'package:pokedex_flutter/models/pokemon_info_response.dart';

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<String> abilities;
  final List<String> moves;
  final List<PokemonStat> stats;
  final String description;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.moves,
    required this.stats,
    required this.description,
  });
  
}