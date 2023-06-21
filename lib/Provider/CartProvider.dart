import 'package:e_commerce/Authenticaiton/Model/Product.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Products> _listProInCart = [];
  int _quantity = 0;

  List<Products> get getListProInCart => _listProInCart;
  int get getQuantity => _quantity;

  add(Products item) {
    _listProInCart.add(item);
    _quantity++;
    notifyListeners();
  }

  remove(Products item) {
    _listProInCart.remove(item);
    _quantity--;
    notifyListeners();
  }
}
