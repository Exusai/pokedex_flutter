import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/blocs/nav_cubit.dart';
import 'package:pokedex_flutter/blocs/pokemon_detail_cubit.dart';
import '../../../models/pokemon.dart';
import '../pokemon_color.dart';

class PokemonDetailView extends StatelessWidget {
  //final Pokemon? pokemon;
  PokemonDetailView();

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
            ],
          )
        );
      },
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsCubit, Pokemon?>(
      builder: (context, state) {
        Pokemon? pokemon = state;
        return pokemon != null 
        ? Scaffold(
          appBar: AppBar(
            backgroundColor: pokemonTypeBackGround(pokemon.types[0]),
            elevation: 0,
          ),
          body: Column(
            children: [
              Container(
              decoration: BoxDecoration(
                color: pokemonTypeBackGround(pokemon.types[0]),
              ),
              child: Hero(
                tag: pokemon.name,
                child: Center(
                  child: Image.network(
                    pokemon.imageUrl,
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
            ],
          )
        ) 
        : Scaffold(
          appBar: AppBar(
            title: const Text('Pokemon Detail Loading'),
            centerTitle: true,
            elevation: 0,
          ),
          body: const Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: CircularProgressIndicator()
            ),
          ),
        );
      },
    );
  } */
}