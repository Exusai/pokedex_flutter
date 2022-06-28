part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent { } 

class AddUser extends UserEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateUser extends UserEvent {
  final User user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class DeleteUser extends UserEvent {
  final User user;

  const DeleteUser(this.user);

  @override
  List<Object> get props => [user];
}