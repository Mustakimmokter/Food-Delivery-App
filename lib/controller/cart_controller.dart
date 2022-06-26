import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/data/repository/cart_repo.dart';
import 'package:food_delivery_app_one/products_model/cart_model.dart';
import 'package:food_delivery_app_one/products_model/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _itemsCount = {};

  Map<int, CartModel> get items => _itemsCount;
  List<CartModel> storageItems = [];

  void addItems(ProductsModel products, int quantity) {
    int totalQuantity = 0;
    if (_itemsCount.containsKey(products.id!)) {
      _itemsCount.update(products.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            img: value.img,
            name: value.name,
            price: value.price,
            isExist: true,
            time: DateTime.now().toString(),
            quantity: value.quantity! + quantity,
            productsModel: products);
      });
      if (totalQuantity <= 0) {
        _itemsCount.remove(products.id);
      }
    } else {
      if (quantity > 0) {
        _itemsCount.putIfAbsent(products.id!, () {
          return CartModel(
              id: products.id,
              img: products.img,
              name: products.name,
              price: products.price,
              isExist: true,
              quantity: quantity,
              time: DateTime.now().toString(),
              productsModel: products);
        });
      } else {
        Get.snackbar(
          'Items count',
          'You should at least add an one item in the cart',
          backgroundColor: Colors.blue[200],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 125),
        );
      }
    }
    cartRepo.adToCartList(getCartItems);
    update();
  }

  bool isExistCart(ProductsModel product) {
    if (_itemsCount.containsKey(product.id!)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductsModel product) {
    int quantity = 0;
    if (_itemsCount.containsKey(product.id)) {
      _itemsCount.forEach((key, value) {
        if (key == product.id!) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    int totalItems = 0;
    _itemsCount.forEach((key, value) {
      totalItems += value.quantity!;
    });
    return totalItems;
  }

  List<CartModel> get getCartItems {
    return _itemsCount.entries.map((e) => e.value).toList();
  }

  int get totalAmount {
    int total = 0;
    _itemsCount.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartDate() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> setCarts) {
    storageItems = setCarts;
    for (int i = 0; i < storageItems.length; i++) {
      _itemsCount.putIfAbsent(
          storageItems[i].productsModel!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistory();
    cleaned();
  }

  void cleaned() {
    _itemsCount = {};
    update();
  }
}
