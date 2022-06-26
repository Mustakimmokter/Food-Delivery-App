import 'package:food_delivery_app_one/app_contants.dart';
import 'package:food_delivery_app_one/controller/cart_controller.dart';
import 'package:food_delivery_app_one/controller/popular_product_controller.dart';
import 'package:food_delivery_app_one/controller/recommended_products_controller.dart';
import 'package:food_delivery_app_one/data/api_clients/api_client.dart';
import 'package:food_delivery_app_one/data/repository/cart_repo.dart';
import 'package:food_delivery_app_one/data/repository/popular_products_repo.dart';
import 'package:food_delivery_app_one/data/repository/recommended_products_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  // Api Client

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppContants.appBaseURI));

  // Repo
  Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => PopularProductController(popularProductsRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductsRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
