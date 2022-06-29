import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/blocs/nav_cubit.dart';
import 'package:pokedex_flutter/blocs/pokemon_detail_cubit.dart';
import 'package:pokedex_flutter/models/pokemon_info_response.dart';
import '../../../models/pokemon.dart';
import '../pokemon_color.dart';

class PokemonDetailView extends StatelessWidget {
  //final Pokemon? pokemon;
  const PokemonDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PokemonImageIdName? pokemonImageIdName = BlocProvider.of<NavCubit>(context).state;

    return BlocBuilder<PokemonDetailsCubit, Pokemon?>(
      builder: (context, state) {
        Pokemon? pokemon = state;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: pokemon != null ? pokemonTypeBackGround(pokemon.types[0]) : Colors.white,
            elevation: 0,
          ),
          backgroundColor: pokemon != null ? pokemonTypeBackGround(pokemon.types[0]) : Colors.white,
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: pokemon != null ? pokemonTypeBackGround(pokemon.types[0]) : Colors.white,
                ),
                child: Hero(
                  tag: pokemonImageIdName!.name,
                  child: Center(
                    child: Image.network(
                      pokemonImageIdName.imageUrl,
                      fit: BoxFit.cover,
                      height: 250,
                      width: 250,
                      loadingBuilder: (context, child, progress){
                        return progress == null ? child : CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,);//LinearProgressIndicator();
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: pokemon != null 
                ? Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: Colors.white,
                  ),
                  //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            pokemon.name.substring(0, 1).toUpperCase() + pokemon.name.substring(1),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          pokemonTypeCapsules(pokemon.types),
                        ],
                      ),
                      //const SizedBox(height: 10),
                      const Divider(color: Colors.grey,),
                      Text(
                        pokemon.description.replaceAll('\n', ' '),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Stats',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.grey,),
                      pokemonStatSlider(pokemon.stats[0], Colors.greenAccent),
                      const SizedBox(height: 10),
                      pokemonStatSlider(pokemon.stats[1], Colors.redAccent),
                      const SizedBox(height: 10),
                      pokemonStatSlider(pokemon.stats[2], Colors.blueAccent),
                      const SizedBox(height: 10),
                      pokemonStatSlider(pokemon.stats[3], Colors.redAccent),
                      const SizedBox(height: 10),
                      pokemonStatSlider(pokemon.stats[4], Colors.greenAccent),
                      const SizedBox(height: 10),
                      pokemonStatSlider(pokemon.stats[5], Colors.blueAccent),
                      const SizedBox(height: 20),

                      const Text(
                        'Abilities',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.grey,),
                      pokemonTypeCapsules(pokemon.abilities),
                      const SizedBox(height: 20),

                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.grey,),
                      pokemonDataRow('Heigth', '${pokemon.height/10} m'),
                      pokemonDataRow('Weight', '${pokemon.weight/10} kg'),
                      const SizedBox(height: 20),

                      ExpansionTile(
                        title: const Text(
                          'Moves',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            childAspectRatio: 5,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: pokemon.moves.map((type) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: pokemonTypeBackGround(type),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                type.substring(0, 1).toUpperCase() + type.substring(1),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            )).toList(),
                          ),
                          const SizedBox(height: 10),
                        ]
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
                : const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          )
        );
      },
    );
  }

  Widget pokemonTypeCapsules(List<String> types){
    return Row(
      children: types.map((type) => Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: pokemonTypeBackGround(type),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          type.substring(0, 1).toUpperCase() + type.substring(1),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      )).toList(),
    );
  }

  Widget pokemonStatSlider(PokemonStat stat, Color color) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                stat.name,
                style: const TextStyle(
                  //fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: Colors.black45,
                ),
              ),
              const Spacer(),
              Text(
                stat.baseStat.toString(),
                style: const TextStyle(
                  //fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Slider(
            value: stat.baseStat.toDouble(),
            min: 0,
            max: 155,
            divisions: 100,
            label: '${stat.baseStat}',
            thumbColor: Colors.transparent,
            activeColor: color,
            onChanged: (double value) {},
          ),
        ),
      ],
    );
  }

  Widget pokemonDataRow(String stat, String value){
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          stat,
          style: const TextStyle(
            //color: Theme.of(context).colorScheme.secondary,
            //fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            //color: Theme.of(context).colorScheme.secondary,
            //fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}