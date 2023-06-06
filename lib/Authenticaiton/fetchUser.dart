import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Model/User.dart';
import 'package:e_commerce/Util/userAuth.dart' as global;
import 'package:http/http.dart' as https;

List<User> parseUser(String responseBody) {
  var list = json.decode(responseBody)! as List<dynamic>;
  List<User> users = list.map((model) => User.fromJson(model)).toList();

  return users;
}

Future<List<User>> fetchUser() async {
  var token = global.token;

  final result = await https.get(Uri.parse('https://api.escuelajs.co/api/v1/users'), headers: {'Authorization': 'Bearer $token'});
  if (result.statusCode == 200) {
    // print(result.statusCode);
    return compute(parseUser, result.body);
  } else {
    throw Exception("Calling Api has Error!!");
  }
}

callUser(String usname) async {
  List<User> abc = await fetchUser();

  for (var singleUser in abc) {
    if (singleUser.email == usname) {
      // print('singleUser');
      return singleUser;
    }
  }
  // return abc;
}
