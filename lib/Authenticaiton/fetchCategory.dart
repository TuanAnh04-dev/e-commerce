import 'dart:convert';

import 'package:e_commerce/Authenticaiton/Model/Category.dart';
import 'package:e_commerce/Util/userAuth.dart' as global;
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as https;

List<CategoryPro> parseCategoryPro(String res) {
  var list = json.decode(res)! as List<dynamic>;
  List<CategoryPro> cates = list.map((e) => CategoryPro.fromJson(e)).toList();

  return cates;
}

Future<List<dynamic>> fetchCategoryPro() async {
  var token = global.token;
  // print(token);
  final result = await https.get(
    Uri.parse('https://dummyjson.com/products/categories'),
    headers: {'Authorization': 'Bearer $token'},
  );
  if (result.statusCode == 200) {
    // print(compute(parseCategoryPro, result.body));
    return json.decode(result.body);
  } else {
    throw Exception("Calling Api has Error!!");
  }
}
