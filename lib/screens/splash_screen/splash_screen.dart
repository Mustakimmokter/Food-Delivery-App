import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/route_helper/route_helper.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_products_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitialPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: _animation,
              child:
                  Center(child: Image.asset('assets/images/MyChart_logo.png'))),
          SizedBox(height: 20),
          Center(
            child: Text(
              'The BD Food',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
