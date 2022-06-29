import 'package:shared_preferences/shared_preferences.dart';

class TeamsFromSharedPrefs {
  TeamsFromSharedPrefs();

  Future<List<String>?> getSavedTeamsNames() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? teamNames = prefs.getStringList('Teams');
    //print ('TeamsFromSharedPrefs.getSavedTeamsNames: teamNames: $teamNames');
    return teamNames;
  }

  Future saveTeam(newTeam) async {
    //print('TeamsFromSharedPrefs.saveTeam: newTeam: $newTeam');
    final prefs = await SharedPreferences.getInstance();
    List<String>? teamNames = prefs.getStringList('Teams');
    teamNames ??= [];

    teamNames.add(newTeam);
    await prefs.setStringList('Teams', teamNames);
  }

  Future deleteTeam(teamName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? teamNames = prefs.getStringList('Teams');
    teamNames ??= [];

    teamNames.remove(teamName);  
    await prefs.setStringList('Teams', teamNames);
    await prefs.remove(teamName);    
  }

}