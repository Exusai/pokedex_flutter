
class PokemonStat{
  final String name;
  final int baseStat;

  PokemonStat({required this.name, required this.baseStat});

  factory PokemonStat.fromJson(Map<String, dynamic> json){
    return PokemonStat(
      name: json['stat']['name'],
      baseStat: json['base_stat']
    );
  }
}

class PokemonInfo {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<String> abilities;
  final List<String> moves;
  final List<PokemonStat> stats;

  PokemonInfo({required this.id, required this.name, required this.imageUrl, required this.types, required this.height, required this.weight, required this.abilities, required this.moves, required this.stats});

  factory PokemonInfo.fromJson(Map<String, dynamic> json){
    final List<String> types = (json['types'] as List).map((typeJson) => typeJson['type']['name'] as String).toList();
    final List<String> abilities = (json['abilities'] as List).map((abilityJson) => abilityJson['ability']['name'] as String).toList();
    final List<String> moves = (json['moves'] as List).map((moveJson) => moveJson['move']['name'] as String).toList();
    final List<PokemonStat> stats = (json['stats'] as List).map((statJson) => PokemonStat.fromJson(statJson)).toList();
    
    return PokemonInfo(
      id: json['id'],
      name: json['name'],
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${json['id']}.png',
      types: types,
      height: json['height'],
      weight: json['weight'],
      abilities: abilities,
      moves: moves,
      stats: stats,
    );
  }
}