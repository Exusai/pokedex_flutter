import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/views/home/pokedex/pokemon_tile.dart';

import '../../../blocs/pokemon/bloc/pokemon_bloc.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PokemonLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: state.pokemonListings.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
              ), 
              itemBuilder: (BuildContext context, int index) { 
                //print(pokemonList[index].name);
                return PokemonTile(pokemonListing: state.pokemonListings[index]);
              }),
          );
        } else if (state is PokemonLoadFailed) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Error: ${state.error}'),
          );
        }
        else {
          return const Center(
            child: Text('Unknown state'),
          );
        }
      },
    );
  }
}