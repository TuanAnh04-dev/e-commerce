import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as https;
import 'package:e_commerce/Authenticaiton/Model/Product.dart';
import 'package:e_commerce/Util/userAuth.dart' as global;

Product parseProduct(String res) {
  var list = json.decode(res);
  Product product = Product.fromJson(list);
  return product;
}

Future<Product> fetchProduct() async {
  var token = global.token;
  // print(token);
  final result = await https.get(
    Uri.parse('https://dummyjson.com/products'),
    headers: {'Authorization': 'Bearer $token'},
  );
  if (result.statusCode == 200) {
    // print(compute(parseProduct, result.body));
    return compute(parseProduct, result.body);
  } else {
    throw Exception("Calling Api has Error!!");
  }
}
