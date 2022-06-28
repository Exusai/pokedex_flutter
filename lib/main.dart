import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/blocs/pokemon/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/blocs/user/bloc/user_bloc.dart';
import 'package:pokedex_flutter/views/auth/register.dart';
import 'package:pokedex_flutter/views/home/pokedex/pokedex_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc()..add(LoadUser()),
        ),
        BlocProvider(
          create: (context) => PokemonBloc()..add(PokemonPageRequest(page: 0)),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          //brightness: Brightness.dark
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter pokedex'),
            elevation: 0,
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitial){
                // getting user from SharedPreferences
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoaded) {
                return const Center(
                  //child: Text(state.user.username),
                  child: PokedexView(),
                );
              } else if (state is NoUser) {
                return const Center(
                  child: UserNameRegister(),
                );
              }
              else {
                return const Center(
                  child: Text('Unknown state'),
                );
              }
            }, 
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
