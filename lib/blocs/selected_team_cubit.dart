import 'package:bloc/bloc.dart';
import 'package:pokedex_flutter/models/team.dart';

class SlectedTeamCubit extends Cubit<Team?> {

  SlectedTeamCubit() : super(null);

  void selectTeam(String teamName) async {
    Team selectedTeam = await Team.fromSharedPreferences(teamName);
    emit(selectedTeam);
  }

  void deselectTeam() {
    emit(null);
  }

  void addPokemonToTeam (Team team,int id) {
    team.addPokemon(id);
    //team.toSharedPreferences();
    emit(team);
  }

  void removePokemonFromTeam (Team team,int id) {
    team.removePokemon(id);
    //team.toSharedPreferences();
    emit(team);
  }

  void saveTeamChanges (Team team) {
    team.toSharedPreferences();
    emit(team);
  }
}