import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/app_navigtion.dart';
import 'package:pokedex_flutter/blocs/nav_cubit.dart';
import 'package:pokedex_flutter/blocs/pokemon/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/blocs/pokemon_detail_cubit.dart';
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
    final PokemonDetailsCubit pokemonDetailsCubit = PokemonDetailsCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc()..add(LoadUser()),
        ),
        BlocProvider(
          create: (context) => PokemonBloc()..add(PokemonPageRequest(page: 0)),
        ),
        BlocProvider(
          create: (context) => NavCubit(pokemonDetailsCubit: pokemonDetailsCubit),
        ),
        BlocProvider(create: (context) => pokemonDetailsCubit),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          dividerColor: Colors.grey,
          sliderTheme: const SliderThemeData(
            trackHeight: 10,
            inactiveTrackColor: Colors.black12,
            //trackShape: RectangularSliderTrackShape(),
            thumbShape: RoundSliderThumbShape(elevation: 0, pressedElevation: 0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
            //thumbColor: Colors.transparent,
          ),
        ),
        
        home: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial){
              // getting user from SharedPreferences
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserLoaded) {
              return const AppNavigator();
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
      ),
    );
  }
}
