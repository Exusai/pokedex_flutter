import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/views/home/pokedex/pokemon_tile.dart';

import '../../../blocs/pokemon/bloc/pokemon_bloc.dart';
import '../../../blocs/user/bloc/user_bloc.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Pokedex'),
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
                    const Divider(color: Colors.white,),
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
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Equipos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Editar usuario'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
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
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: state.pokemonListings.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ), 
                itemBuilder: (BuildContext context, int index) { 
                  //print(pokemonList[index].name);
                  return PokemonTile(pokemonListing: state.pokemonListings[index]);
                }),
            );
          } else if (state is PokemonLoadFailed) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Error: ${state.error}'),
            );
          }
          else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }
}