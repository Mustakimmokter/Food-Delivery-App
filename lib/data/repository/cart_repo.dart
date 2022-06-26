import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../products_model/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void adToCartList(List<CartModel> cartList) {
    cart = [];
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList('Cart-List', cart);
    //print(sharedPreferences.getStringList('Cart-List'));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey('Cart-List')) {
      carts = sharedPreferences.getStringList('Cart-List')!;
      print(carts.toString());
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey('Cart-History-List')) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList('Cart-History-List')!;
    }
    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) =>
        cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));
    return cartHistoryList;
  }

  void addToCartHistory() {
    if (sharedPreferences.containsKey('Cart-History-List')) {
      cartHistory = sharedPreferences.getStringList('Cart-History-List')!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList('Cart-History-List', cartHistory);
  }

  removeCart() {
    cart = [];
    sharedPreferences.remove('Cart-List');
  }
}
