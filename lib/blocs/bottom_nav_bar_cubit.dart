import 'package:bloc/bloc.dart';

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