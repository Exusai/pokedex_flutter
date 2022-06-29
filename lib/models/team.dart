// ignore_for_file: non_constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

class Team {
  final String name;
  bool isFull  = false;
  List<int> IDs = [];

  Team(this.name, this.isFull, this.IDs);
  
  void addPokemon(int id) {
    if (!isFull) {
      IDs.add(id);
      if (IDs.length == 6) isFull = true;
      if (IDs.length < 6) isFull = false;
      
    }
  }

  void removePokemon(int id) {
    if (!isFull) {
      IDs.remove(id);
      if (IDs.length == 6) isFull = true;
      if (IDs.length < 6) isFull = false;
    }
  }

  static Future <Team> fromSharedPreferences(String name) async {
    List<int> ids = [];
    bool isFull = false;

    final prefs = await SharedPreferences.getInstance();
    final List<String>? pokemonIDs = prefs.getStringList(name);

    if (pokemonIDs != null) {
      for (String id in pokemonIDs) {
        ids.add(int.parse(id));
      }
      if (ids.length == 6) isFull = true;
      if (ids.length < 6) isFull = false;
    }

    return Team(name, isFull, ids);
  }

  void toSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(name, IDs.map((id) => id.toString()).toList());
  }

}