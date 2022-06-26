import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/controller/cart_controller.dart';
import 'package:food_delivery_app_one/data/repository/popular_products_repo.dart';
import 'package:food_delivery_app_one/products_model/cart_model.dart';
import 'package:food_delivery_app_one/products_model/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductsRepo popularProductsRepo;
  PopularProductController({required this.popularProductsRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cartController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _productsQuantity = 0;
  int _inCartItems = 0;

  int get productsQuantity => _productsQuantity;
  int get inCartItems => _inCartItems + _productsQuantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductsRepo.getPopularProductsList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList
          .addAll(Products.fromJson(response.body).productsModel);
      update();
      _isLoading = true;
    } else {}
  }

  /// Item count method
  getItem(bool item) {
    if (item == true) {
      _productsQuantity++;
      if ((_inCartItems + _productsQuantity) > 20) {
        _productsQuantity = 20;
        Get.snackbar(
          'Item count',
          'You can\'t reduce more!',
          colorText: Colors.white,
          backgroundColor: Colors.blue[200],
        );
      }
    } else if (item == false) {
      _productsQuantity--;
      if ((_inCartItems + _productsQuantity) < 0) {
        _productsQuantity = 0;
        Get.snackbar(
          'Item count',
          'You can\'t add more!',
          colorText: Colors.white,
          backgroundColor: Colors.blue[200],
        );
      }
    }
    update();
  }

  void initProducts(ProductsModel product, CartController cart) {
    _productsQuantity = 0;

    _inCartItems = 0;
    _cartController = cart;
    bool isExist = false;
    isExist = _cartController.isExistCart(product);
    if (isExist) {
      _inCartItems = _cartController.getQuantity(product);
    }
  }

  void addItems(ProductsModel products) {
    _cartController.addItems(products, _productsQuantity);
    _productsQuantity = 0;
    _inCartItems = _cartController.getQuantity(products);
    _cartController.items.forEach((key, value) {
      print('id: ${value.id!} qu: ${value.quantity}');
    });

    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getCartItems {
    return _cartController.getCartItems;
  }
}
