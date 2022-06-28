import 'package:flutter/material.dart';
import 'package:pokedex_flutter/models/pokemon_response.dart';

class PokemonTile extends StatelessWidget {
  final PokemonListing pokemonListing;
  
  PokemonTile({required this.pokemonListing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetail(pokemon: pokemon),
          ),
        ); */
      },
      child: Container(
        //height: 1000,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: [
            // make widget semi-transparent
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: pokemonTypeBackGround(pokemon.types),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: Colors.black38,
                    ),
                    child: Text(pokemonListing.name, style: const TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center)
                  ),
                )
              ],
            ),
            Hero(
              tag: pokemonListing.name,
              child: Image.network(
                pokemonListing.imageUrl,
                fit: BoxFit.fill,
                alignment: Alignment.center,
                height: 250,
                width: 250,
                loadingBuilder: (context, child, progress){
                  return progress == null ? child : SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );//LinearProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}