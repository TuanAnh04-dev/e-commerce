import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'AuthRepository.dart';
import 'Login/bloc/login_bloc.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => LoginPage());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: BlocProvider(
          create: (context) {
            return LoginBloc(authRepo: RepositoryProvider.of<AuthRepository>(context));
          },
          child: const LoginView(),
        ),
      ),
    );
  }
}
