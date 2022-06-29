import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/teams_from_shared_prefs.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc() : super(TeamsInitial()) {
    on<LoadTeams>(
      (event, emit) async {
        emit(TeamsLoading());
        try {
          final List<String>? teams = await TeamsFromSharedPrefs().getSavedTeamsNames();
          if (teams != null) {
            emit(TeamsLoaded(teams: teams));
          } else {
            emit(NoTeamsLoaded());
          }
        } catch (error) {
          emit(NoTeamsLoaded());
        }
      }
    );
  }
}
