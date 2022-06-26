import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/controller/cart_controller.dart';
import 'package:food_delivery_app_one/route_helper/route_helper.dart';
import 'package:get/get.dart';

import 'controller/popular_product_controller.dart';
import 'controller/recommended_products_controller.dart';
import 'dependencies/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartDate();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteHelper.getSplashScreen(),
          getPages: RouteHelper.getRoutes,
        );
      });
    });
  }
}
