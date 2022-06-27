import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>(
      (event, emit) async {
        // Load user from SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? username = prefs.getString('username');
        if (username != null) {
          emit(UserLoaded(user: User(username: username)));
        } else {
          emit(NoUser());
        }
      }
    );

    on<AddUser>(
      (event, emit) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', event.user.username);
        //print ('User added' + event.user.username);
        emit(UserLoaded(user: User(username: event.user.username)));
      }
    );

    on<UpdateUser>(
      (event, emit) async {
        if(state is UserLoaded){
          // Update user in SharedPreferences
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', event.user.username);

          emit(UserLoaded(user: User(username: event.user.username)));
        }
      }
    );
  }
}
