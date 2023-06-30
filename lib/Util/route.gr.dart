// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:e_commerce/Authenticaiton/login_view.dart' as _i1;
import 'package:e_commerce/Home/HomePage.dart' as _i2;
import 'package:e_commerce/Home/ProductDetail.dart' as _i3;
import 'package:e_commerce/home_page.dart' as _i4;
import 'package:flutter/material.dart' as _i6;

abstract class $RootRoute extends _i5.RootStackRouter {
  $RootRoute({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LoginView.name: (routeData) {
      final args =
          routeData.argsAs<LoginViewArgs>(orElse: () => const LoginViewArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.LoginView(
          key: args.key,
          onLoginresult: args.onLoginresult,
        ),
      );
    },
    Homepage.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Homepage(),
      );
    },
    ProductDetail.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ProductDetail(),
      );
    },
    Home.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.Home(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginView]
class LoginView extends _i5.PageRouteInfo<LoginViewArgs> {
  LoginView({
    _i6.Key? key,
    void Function(bool)? onLoginresult,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          LoginView.name,
          args: LoginViewArgs(
            key: key,
            onLoginresult: onLoginresult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginView';

  static const _i5.PageInfo<LoginViewArgs> page =
      _i5.PageInfo<LoginViewArgs>(name);
}

class LoginViewArgs {
  const LoginViewArgs({
    this.key,
    this.onLoginresult,
  });

  final _i6.Key? key;

  final void Function(bool)? onLoginresult;

  @override
  String toString() {
    return 'LoginViewArgs{key: $key, onLoginresult: $onLoginresult}';
  }
}

/// generated route for
/// [_i2.Homepage]
class Homepage extends _i5.PageRouteInfo<void> {
  const Homepage({List<_i5.PageRouteInfo>? children})
      : super(
          Homepage.name,
          initialChildren: children,
        );

  static const String name = 'Homepage';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ProductDetail]
class ProductDetail extends _i5.PageRouteInfo<void> {
  const ProductDetail({List<_i5.PageRouteInfo>? children})
      : super(
          ProductDetail.name,
          initialChildren: children,
        );

  static const String name = 'ProductDetail';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.Home]
class Home extends _i5.PageRouteInfo<void> {
  const Home({List<_i5.PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
