import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokedex_flutter/models/team.dart';



class TeamsFromSharedPrefs {
  TeamsFromSharedPrefs();

  Future<List<String>?> getSavedTeamsNames() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? teamNames = prefs.getStringList('Teams');
    
    return teamNames;
  }

}