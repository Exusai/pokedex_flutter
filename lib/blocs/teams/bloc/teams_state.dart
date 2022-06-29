part of 'teams_bloc.dart';

@immutable
abstract class TeamsState {}

class TeamsInitial extends TeamsState {}

class TeamsLoading extends TeamsState {}

class TeamsLoaded extends TeamsState {
  final List<String> teams;

  TeamsLoaded({
    required this.teams,
  });
}

class NoTeamsLoaded extends TeamsState {}
