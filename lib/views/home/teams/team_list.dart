import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/views/home/teams/team_view.dart';
import '../../../blocs/selected_team_cubit.dart';
import '../../../blocs/teams/bloc/teams_bloc.dart';

class TeamsListView extends StatelessWidget {
  const TeamsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        if (state is TeamsLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TeamsLoaded) {
          return ListView.builder(
            itemCount: state.teams.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(state.teams[index]),
                onDismissed: (direction) {
                  BlocProvider.of<TeamsBloc>(context).add(DeleteTeam(teamName: state.teams[index]));
                },
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  child: const ListTile(
                    title: Text('Delete', style: TextStyle(color: Colors.white)),
                    leading: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: ListTile(
                  title: Text(state.teams[index]),
                  leading: const Icon(Icons.sports_esports),
                  onTap: () {
                    // Cambia el estado del cubit para que se seleccione el team
                    BlocProvider.of<SlectedTeamCubit>(context).selectTeam(state.teams[index]);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TeamView(teamName: state.teams[index]),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is NoTeamsLoaded) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('No tienes equipos, inicia por crear uno desde la Pokedex'),
                /* ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<BottomNavCubit>(context).goToPokedex();
                  },
                  child: const Text('Go to Pokedex'),
                ) */
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Unknown state'),
          );
        }
      },
    );
  }
}