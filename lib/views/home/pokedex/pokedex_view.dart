import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/views/home/pokedex/pokemon_tile.dart';
import '../../../blocs/bottom_nav_bar_cubit.dart';
import '../../../blocs/pokemon/bloc/pokemon_bloc.dart';
import '../teams/team_list.dart';

class PokedexGridView extends StatelessWidget {
  const PokedexGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        // if bottom nav is in pokedex (index 0)
        if (state == 0) {
          return BlocBuilder<PokemonBloc, PokemonState>(
            builder: (context, state) {
              if (state is PokemonLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PokemonLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: state.pokemonListings.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        //print(pokemonList[index].name);
                        return PokemonTile(
                            pokemonListing: state.pokemonListings[index]);
                      }),
                );
              } else if (state is PokemonLoadFailed) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Error: ${state.error}'),
                );
              } else {
                return const Center(
                  child: Text('Unknown state'),
                );
              }
            },
          );
        } else if (state == 1) {
          // if bottom nav is in teams (index 1)
          return const TeamsListView();
        } else {
          return const Center(
            child: Text('Unknown state'),
          );
        }
        
      },
    );
  }
}
