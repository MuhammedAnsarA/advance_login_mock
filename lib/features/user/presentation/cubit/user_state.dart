part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();

  @override
  List<Object> get props => [];
}

class SingleUserLoaded extends UserState {
  final LocalUser user;

  const SingleUserLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class GetAllUsersLoaded extends UserState {
  final List<LocalUser> users;

  const GetAllUsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);
  @override
  List<Object> get props => [message];
}
