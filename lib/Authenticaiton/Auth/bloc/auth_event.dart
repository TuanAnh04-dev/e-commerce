part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged(this.status);

  final AuthStatus status;
  @override
  List<Object> get props => [status];
}

class AuthUsernameChanged extends AuthEvent {
  final String username;
  const AuthUsernameChanged({required this.username});
  @override
  List<Object> get props => [username];
}

class AuthLogoutRequested extends AuthEvent {}
