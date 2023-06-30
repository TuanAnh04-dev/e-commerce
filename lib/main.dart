import 'dart:ui';

import 'package:e_commerce/Provider/CartProvider.dart';
import 'package:e_commerce/Util/AuthProvider.dart';
import 'package:e_commerce/Util/route.dart';
import 'package:e_commerce/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';

import 'Authenticaiton/Auth/bloc/auth_bloc.dart';
import 'Authenticaiton/AuthRepository.dart';
import 'Authenticaiton/UserRepository.dart';
import 'Util/appInfo.dart' as global;

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<CartProvider>(CartProvider(), signalsReady: true);
  getIt.registerFactory<AuthBloc>(() => AuthBloc(authRepo: AuthRepository(), userRepo: UserRepository()));
  global.isAuth = false;
  runApp(MyApp(
    authRepository: AuthRepository(),
    userRepository: UserRepository(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    RootRoute _appRouter = RootRoute();
    final authProvider = AuthProvider();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // navigatorKey: _navigatorKey,
      routerConfig: _appRouter.config(
          // reevaluateListenable: authProvider,
          ),
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // print(state.status);
            switch (state.status) {
              case AuthStatus.unauthenticated:
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: const Text('Thất bại !!!')));
                _navigator.pushNamedAndRemoveUntil('/login', (route) => true);
                global.isAuth = false;
                break;
              case AuthStatus.authenticated:
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: const Text('Đăng nhập thành công !!!')));
                _navigator.pushNamedAndRemoveUntil('home', (route) => true);
                global.isAuth = true;
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      // onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  const MyApp({
    Key? key,
    required this.authRepository,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(
          authRepo: authRepository,
          userRepo: userRepository,
        ),
        child: const MainApp(),
      ),
    );
  }
}
