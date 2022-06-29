part of 'teams_bloc.dart';

@immutable
abstract class TeamsEvent {}

class LoadTeams extends TeamsEvent {}

class DeleteTeam extends TeamsEvent {
  final String teamName;

  DeleteTeam({
    required this.teamName,
  });
}
