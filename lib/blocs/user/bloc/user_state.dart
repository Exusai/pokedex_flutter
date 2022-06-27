part of 'user_bloc.dart';

@immutable
abstract class UserState {
  const UserState();

  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded({required this.user});

  @override
  List<Object?> get props => [user]; 
} 

class NoUser extends UserState {}