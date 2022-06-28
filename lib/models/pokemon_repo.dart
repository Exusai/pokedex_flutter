import 'dart:convert';
import 'package:pokedex_flutter/models/pokemon_response.dart';
import 'package:http/http.dart' as http;

class PokemonRepository{
  final http.Client httpClient = http.Client();
  final String baseUrl = 'pokeapi.co';

  Future<PokemonPageResponse> getPokemonPage(int page) async {
    
    final queryParameters = {
      'limit': '150',
      'offset': '${page * 150}'
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon/', queryParameters);
    final response = await httpClient.get(uri);
    final json = jsonDecode(response.body);

    return PokemonPageResponse.fromJson(json); 
  }
}