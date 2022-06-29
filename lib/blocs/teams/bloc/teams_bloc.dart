import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/teams_from_shared_prefs.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc() : super(TeamsInitial()) {
    on<LoadTeams>(
      (event, emit) async {
        //emit(TeamsLoading());
        final List<String>? teams = await TeamsFromSharedPrefs().getSavedTeamsNames();
        if (teams != null && teams.isNotEmpty) {
          emit(TeamsLoaded(teams: teams));
        } else {
          emit(NoTeamsLoaded());
        }
      }
    );

    on<DeleteTeam>(
      (event, emit) async {
        await TeamsFromSharedPrefs().deleteTeam(event.teamName);
        final List<String>? teams = await TeamsFromSharedPrefs().getSavedTeamsNames();
        if (teams != null && teams.isNotEmpty) {
          emit(TeamsLoaded(teams: teams));
        } else {
          emit(NoTeamsLoaded());
        }
      }
    );

    on<AddTeam>(
      (event, emit) async {
        await TeamsFromSharedPrefs().saveTeam(event.teamName);
        final List<String>? teams = await TeamsFromSharedPrefs().getSavedTeamsNames();
        if (teams != null && teams.isNotEmpty) {
          emit(TeamsLoaded(teams: teams));
        } else {
          emit(NoTeamsLoaded());
        }
      }
    );
  }
}
