class PokemonSpeciesInfo {
  final String description;

  PokemonSpeciesInfo({required this.description});

  factory PokemonSpeciesInfo.fromJson(Map<String, dynamic> json){
    return PokemonSpeciesInfo(
      description: json['flavor_text_entries'][0]['flavor_text']
    );
  }
}