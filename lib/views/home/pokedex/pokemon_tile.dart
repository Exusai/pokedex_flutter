import 'package:flutter/material.dart';
import 'package:pokedex_flutter/models/pokemon_response.dart';

import '../pokemon_color.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Stack(
          children: [ 
            FutureBuilder(
              future: fetchPokemonColor(pokemonListing.name),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final pokeFetchTile = snapshot.data as PokeFetchTile;
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: pokeFetchTile.color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),

                            Container(
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(pokeFetchTile.types[0], style: const TextStyle(fontSize: 15, color: Colors.white, height: 1.3,), textAlign: TextAlign.center)
                            ),

                            pokeFetchTile.types.length >= 2 ? const SizedBox(height: 5): Container(),

                            pokeFetchTile.types.length >= 2 ? Container(
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(pokeFetchTile.types[1], style: const TextStyle(fontSize: 15, color: Colors.white, height: 1.3,), textAlign: TextAlign.center)
                            ): Container(),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey[200]!,
                          Colors.grey[500]!,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }
              },
            ),   
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.black26,
                    ),
                    child: Text('  ${pokemonListing.name.substring(0, 1).toUpperCase() + pokemonListing.name.substring(1)}', style: const TextStyle(fontSize: 23, color: Colors.white, height: 1.3,), textAlign: TextAlign.left)
                  ),
                )
              ],
            ),
            
            Positioned(
              bottom: -5,
              right: -10,
              child: Hero(
                tag: pokemonListing.name,
                child: Image.network(
                  pokemonListing.imageUrl,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  height: 110,
                  width: 110,
                  loadingBuilder: (context, child, progress){
                    return progress == null ? child : SizedBox(
                      height: 110,
                      width: 110,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );//LinearProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}