import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokeFetchTile {
  Color color;
  List<String> types;

  PokeFetchTile({required this.color, required this.types});
}

Color pokemonTypeBackGround(String type) { 
  // change color depending on type
  Color bg = type == 'normal' ? Colors.green :
  type == 'fire' ? Colors.red :
  type == 'water' ? Colors.blue :
  type == 'electric' ? Colors.yellow :
  type == 'grass' ? Colors.green :
  type == 'ice' ? Colors.cyan :
  type == 'fighting' ? Colors.orange :
  type == 'poison' ? Colors.purple :
  type == 'ground' ? Colors.brown :
  type == 'flying' ? Colors.indigo :
  type == 'psychic' ? Colors.pink :
  type == 'bug' ? Colors.lime :
  type == 'rock' ? Colors.brown :
  type == 'ghost' ? Colors.purple :
  type == 'dragon' ? Colors.indigo :
  type == 'dark' ? Colors.purple :
  type == 'steel' ? Colors.grey :
  type == 'fairy' ? Colors.pink :
  Colors.grey;
  
  return bg;
}

Future<PokeFetchTile> fetchPokemonColor(String name) async {
  http.Client httpClient = http.Client();
  final uri = Uri.https('pokeapi.co', '/api/v2/pokemon/$name');
  http.Response response = await httpClient.get(uri);

  Color colorToReturn = Colors.grey;
  List<String> types = [];
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    for (var i = 0; i < json['types'].length; i++) {
      types.add(json['types'][i]['type']['name']);
    } 
    colorToReturn = pokemonTypeBackGround(json['types'][0]['type']['name'].toString());
  } else {
    throw Exception('Failed to load pokemon color');
  }

  PokeFetchTile pokeFetchTile = PokeFetchTile(color: colorToReturn, types: types);
  return pokeFetchTile;
}