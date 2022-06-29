import 'package:bloc/bloc.dart';
import 'package:pokedex_flutter/blocs/pokemon_detail_cubit.dart';

class BottomNavCubit extends Cubit<int> {

  BottomNavCubit() : super(0);

  void goToPokedex() {
    //start loding teams
    //pokemonDetailsCubit.getPokemonDetails(pokemonID);
    emit(0);
  }

  void goToTeams() {
    emit(1);
  }
}