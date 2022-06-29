import 'package:shared_preferences/shared_preferences.dart';



class TeamsFromSharedPrefs {
  TeamsFromSharedPrefs();

  Future<List<String>?> getSavedTeamsNames() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? teamNames = prefs.getStringList('Teams');
    
    return teamNames;
  }

}