import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/blocs/teams/bloc/teams_bloc.dart';
import 'package:pokedex_flutter/models/user.dart';
import 'package:pokedex_flutter/views/home/pokedex/pokedex_view.dart';
import '../../../blocs/bottom_nav_bar_cubit.dart';
import '../../../blocs/user/bloc/user_bloc.dart';
import '../../blocs/selected_team_cubit.dart';
import '../../models/team.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  String newUser = '';
  String newTeamName = '';

  void superSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SlectedTeamCubit, Team?>(
          builder: (context, state) {
            if (state == null) {
              return const Text('Flutter Pokedex');
            } else {
              if (state.isFull){
                return const Text('Team Full');
              } else {
                return Text('${state.IDs.length}/6 seleccionados');
              }
            }
          },
        ),

        actions: [
          BlocBuilder<SlectedTeamCubit, Team?>(
          builder: (context, state) {
            if (state == null) {
              return Container();
            } else {
              return IconButton(
                onPressed: (){
                  BlocProvider.of<SlectedTeamCubit>(context).deselectTeam();
                  setState(() {});
                }, 
                icon: const Icon(Icons.clear),
              );
            }
          },
        ),
        ],
        centerTitle: true,
        elevation: 0,
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Flutter Pokedex App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Por: Samuel Arellano',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoaded) {
                          return Text(
                            'Bienvenido, ${state.user.username}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Pokedex'),
              dense: true,
              onTap: () {
                BlocProvider.of<BottomNavCubit>(context).goToPokedex();
                setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Equipos'),
              dense: true,
              onTap: () {
                BlocProvider.of<BottomNavCubit>(context).goToTeams();
                setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              dense: true,
              title: const Text('Editar usuario'),
              onTap: () {
                usernameChangeDialog();
              },
            ),
            ListTile(
              dense: true,
              title: const Text('Borrar usuario'),
              onTap: () {
                // Obtener info de usuario, si "inició sesión", borrar
                final userState = BlocProvider.of<UserBloc>(context).state;
                if (userState is UserLoaded) {
                  context.read<UserBloc>().add(DeleteUser(userState.user));
                }
              },
            ),
          ],
        ),
      ),
      
      body: PokedexGridView(superSetstate: superSetState),

      floatingActionButton: BlocProvider.of<BottomNavCubit>(context).state == 0 ? FloatingActionButton(
        onPressed: () {
          Team? teamState = BlocProvider.of<SlectedTeamCubit>(context).state;
          if (teamState == null){
            teamToAddpokemonsTo();
          } else {
            //print('saving team ${teamState.name}');
            // save pokemons
            BlocProvider.of<SlectedTeamCubit>(context).saveTeamChanges(BlocProvider.of<SlectedTeamCubit>(context).state!);
            BlocProvider.of<SlectedTeamCubit>(context).deselectTeam();
            setState(() {});
          }

          setState(() {});
        },
        child: BlocProvider.of<SlectedTeamCubit>(context).state == null ? const Icon(Icons.edit) : const Icon(Icons.check),
      ): null,

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Pokedex',
            icon: Icon(
              Icons.tablet
            ),
          ),
          BottomNavigationBarItem(
            label: 'Equipos',
            icon: Icon(Icons.sports_esports),
          ),
        ],
        currentIndex: BlocProvider.of<BottomNavCubit>(context).state,
        selectedItemColor: Colors.red,
        onTap: (int index) {
          if (index == 0) {
            setState(() {});
            BlocProvider.of<BottomNavCubit>(context).goToPokedex();
          } else if (index == 1) {
            setState(() {});
            BlocProvider.of<BottomNavCubit>(context).goToTeams();
          }
        },
      ),
    );
  }

  Future teamToAddpokemonsTo() => showDialog(
    context: context, 
    builder: (context) => SimpleDialog(
      title: const Text('Seleccione un equipo para añadir nuevos pokemones'),
      children: <Widget>[
        BlocBuilder<TeamsBloc, TeamsState>(
          builder: (context, state) {
            if (state is TeamsLoaded) {
              return Column(
                children: state.teams.map((team) => ListTile(
                title: Text(team),
                onTap: () {
                  BlocProvider.of<SlectedTeamCubit>(context).selectTeam(team);
                  setState(() {});
                  Navigator.pop(context);
                },
              )).toList()
              );
            } else if (state is TeamsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NoTeamsLoaded) {
              return const Center(
                child: Text('No hay equipos', style: TextStyle(fontSize: 20)),
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
        TextButton(
          onPressed: () {
            newTeam();
          }, 
          child: const Text('Nuevo equipo'),
        ),

        TextButton(
          onPressed: () {
            Navigator.pop(context, 0);
          }, 
          child: const Text('Cancelar')
        ),
      ],
    )
  );

  Future newTeam() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Nuevo equipo'),
      content: Form(
        key: _formkey2,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre del equipo',
          ),
          validator: (val) =>
              val!.isEmpty ? 'Ingresar un nombre de equpo' : null,
          onChanged: (value) {
            newTeamName = value;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text('Aceptar'),
          onPressed: () {
            if (_formkey2.currentState!.validate()) {
              //print('Trying to add team $newTeamName');
              context.read<TeamsBloc>().add(AddTeam(teamName: newTeamName));
              newTeamName = '';
              Navigator.pop(context);
            }
          },
        ),
      ],
    ),
  );

  Future usernameChangeDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Cambiar nombre de usuario'),
      content: Form(
        key: _formkey,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nuevo nombre de usuario',
          ),
          validator: (val) =>
              val!.isEmpty ? 'Ingresar un nombre de usuario' : null,
          onChanged: (value) {
            newUser = value;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text('Aceptar'),
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              context.read<UserBloc>().add(UpdateUser(User(username: newUser)));
              newUser = '';
              Navigator.pop(context);
            }
          },
        ),
      ],
    ),
  );
}