// ignore_for_file: prefer_const_constructors, unused_import, use_rethrow_when_possible

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commerce/Util/userAuth.dart' as global;

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthStatus>();
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
        headers: {"connection": "Keep-Alive"},
        body: {
          'email': username,
          'password': password,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        var token = json.decode(response.body);

        global.token = token['access_token'];
        Future.delayed(Duration(seconds: 1), () => _controller.add(AuthStatus.authenticated));
      } else {
        Future.delayed(Duration(seconds: 1), () => _controller.add(AuthStatus.unauthenticated));
      }
    } catch (e) {
      throw e;
    }
  }
}
