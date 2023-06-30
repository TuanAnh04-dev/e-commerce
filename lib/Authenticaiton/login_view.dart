// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, must_be_immutable

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'Login/bloc/login_bloc.dart';
import 'Login/bloc/login_state.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key, this.onLoginresult});

  final void Function(bool isLoggedIn)? onLoginresult;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: const Text('Thất bại !!!')));
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: _Logo(),
                  ),
                  _UsernameInput(),
                  Padding(padding: EdgeInsets.only(bottom: 15)),
                  _PasswordInput(),
                  Padding(padding: EdgeInsets.only(bottom: 50)),
                  _LoginButton(),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Text(
                    "Forget password ???",
                    style: TextStyle(color: Colors.blue[600]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Not a member? ",
                    ),
                    Text(
                      "Register",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
              // Padding(padding: EdgeInsets.only(bottom: 1)),
            ],
          ),
        ));
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Image.asset('assets/images/logo01.png'),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  putUN(String data, BuildContext context) {
    context.read<LoginBloc>().add(LoginUsernameChanged(username: data));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextField(
            // controller: unController,
            key: Key('loginForm_usernameInput_textField'),
            onChanged: (username) {
              // print('UI :${username}');
              // context.read<LoginBloc>().add(LoginUsernameChanged(username: username));
              putUN(username, context);
            },
            //john@mail.com
            //changeme
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Color.fromRGBO(21, 115, 254, 1),
                  width: 1,
                ),
              ),
              labelText: 'username',
              errorText: state.username.invalid ? 'invalid username' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    putPW(String data, BuildContext context) {
      context.read<LoginBloc>().add(LoginPasswordChanged(password: data));
      print('====================================putPW');
    }

    // TextEditingController pwController = TextEditingController();

    return BlocBuilder<LoginBloc, LoginState>(
      // buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: TextField(
            // controller: pwController,
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) {
              // print('UI :${password}');
              // pwController.text = password;
              context.read<LoginBloc>().add(LoginPasswordChanged(password: password));
              putPW(password, context);
            },
            obscureText: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Color.fromRGBO(21, 115, 254, 1),
                  width: 1,
                ),
              ),
              labelText: 'password',
              errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    pressLogin(BuildContext context) {
      context.read<LoginBloc>().add(LoginSubmitted());
    }

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(21, 115, 254, 1),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        pressLogin(context);

                        // print('Submit');
                      }
                    : null,
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white),
                ),
              );
      },
    );
  }
}

// john@mail.com
// changeme