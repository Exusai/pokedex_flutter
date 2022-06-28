class PokemonListing{
  final int id;
  final String name;
  final String imageUrl;

  PokemonListing({required this.id, required this.name, required this.imageUrl});

  factory PokemonListing.fromJson(Map<String, dynamic> json){
    String url = json['url'] as String;
    String id = url.split('/')[6];
    return PokemonListing(
      id: int.parse(id),
      name: json['name'],
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

}
class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNext;

  PokemonPageResponse({required this.pokemonListings, required this.canLoadNext});

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json){
    final List<dynamic> pokemonListingsJson = json['results'];
    final List<PokemonListing> pokemonListings = pokemonListingsJson.map((json) => PokemonListing.fromJson(json)).toList();
    return PokemonPageResponse(
      pokemonListings: pokemonListings,
      canLoadNext: json['next'] != null
    );
  } 

}