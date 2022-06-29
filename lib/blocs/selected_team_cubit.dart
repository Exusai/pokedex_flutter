import 'package:bloc/bloc.dart';

class SlectedTeamCubit extends Cubit<String?> {

  SlectedTeamCubit() : super(null);

  void selectTeam(String teamName) {
    emit(teamName);
  }

  void deselectTeam() {
    emit(null);
  }
}