// ignore_for_file: unused_element

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/Authenticaiton/fetchUser.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../AuthRepository.dart';
import '../../Model/User.dart';
import '../../UserRepository.dart';
import 'package:e_commerce/Util/userAuth.dart' as global;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with ChangeNotifier {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthStatus> _authStatusSubcription;

  AuthBloc({
    required AuthRepository authRepo,
    required UserRepository userRepo,
  })  : _authRepository = authRepo,
        _userRepository = userRepo,
        super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthenticationStatusChanged);
    _authStatusSubcription = _authRepository.status.listen(
      (status) => add(AuthStatusChanged(status)),
    );
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    // print(event.status);
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
      case AuthStatus.authenticated:
        var uname = global.username;
        final user = await callUser(uname);

        // final secret = GetStorage();
        // secret.write('user_auth', 'user ne`');
        global.userAuth = user!;
        // final secret = await SharedPreferences.getInstance();
        // await secret.setString('user_auth', user.toString());

        return emit(user != null ? AuthState.authenticated(user) : const AuthState.unauthenticated());
      default:
        emit(const AuthState.unknown());
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
