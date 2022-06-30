import 'package:flutter/material.dart';
import 'package:pokedex_flutter/blocs/nav_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/views/home/home.dart';
import 'package:pokedex_flutter/views/home/pokedex/pokemon_detail.dart';


class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  final heroC = HeroController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, PokemonImageIdName?>(
      builder: (context, pokemonID) {
        return Navigator(
          pages: [
            const MaterialPage(child: PokedexView()),
            if(pokemonID != null) const MaterialPage(child: PokemonDetailView()),            
          ],

          onPopPage: (route, result) {
            //BlocProvider.of<NavCubit>(context).popToPokedex();
            return route.didPop(result);
          },
          observers: [heroC],
        );
      },
    );
  }
}