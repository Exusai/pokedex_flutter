import 'dart:convert';
import 'package:pokedex_flutter/models/pokemon_response.dart';
import 'package:http/http.dart' as http;

class PokemonRepository{
  //final Dio dio = Dio();
  final http.Client httpClient = http.Client();
  final String baseUrl = 'pokeapi.co';

  Future<PokemonPageResponse> getPokemonPage(int page) async {
    
    final queryParameters = {
      'limit': '50',
      'offset': '${page * 50}'
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon/', queryParameters);
    final response = await httpClient.get(uri);
    final json = jsonDecode(response.body);

    /* final response = await dio.get(
      baseUrl,
      queryParameters: {
        'limit': '50',
        'offset': '${page * 50}'
      }
    ); */
    //print (response.statusCode);
    //print(response.data['results']);
    //print(json['results']);
    
    // convert response to json
    //final jsonResponse = json.decode(response.data);
    return PokemonPageResponse.fromJson(json); 
  }
}