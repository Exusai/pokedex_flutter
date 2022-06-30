import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/models/pokemon_response.dart';
import 'package:pokedex_flutter/models/team.dart';
import '../../../blocs/pokemon/bloc/pokemon_bloc.dart';
import '../../../blocs/selected_team_cubit.dart';
import '../pokedex/pokemon_tile.dart';

class TeamView extends StatefulWidget {
  final String teamName;

  const TeamView({Key? key, required this.teamName}) : super(key: key);

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    Team? team = BlocProvider.of<SlectedTeamCubit>(context).state;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teamName),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              BlocProvider.of<SlectedTeamCubit>(context).deselectTeam();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonLoaded) {
            // filter pokemons which are not in the team
            final pokemons = state.pokemonListings.where((pokemon) => team?.IDs.contains(pokemon.id) ?? false).toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: pokemons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return PokemonTile(pokemonListing: pokemons[index], isSelected: false,);
                }
              ),
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
      ),
    );
  }
}