import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../Model/info.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Username username;
  final Password password;

  const LoginState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
  }) {
    return LoginState(status: status ?? this.status, username: username ?? this.username, password: password ?? this.password);
  }

  @override
  List<Object> get props => [status, username, password];
}
