import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/app_contants.dart';
import 'package:food_delivery_app_one/controller/cart_controller.dart';
import 'package:food_delivery_app_one/controller/popular_product_controller.dart';
import 'package:food_delivery_app_one/controller/recommended_products_controller.dart';
import 'package:food_delivery_app_one/custom_widgets/big_text.dart';
import 'package:food_delivery_app_one/custom_widgets/small_text.dart';
import 'package:get/get.dart';

import '../custom_widgets/custom_icon_button.dart';
import '../custom_widgets/rounded_button.dart';
import '../route_helper/route_helper.dart';

class CartPageOne extends StatelessWidget {
  const CartPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Back button
                RoundedButton(
                  icon: Icons.arrow_back,
                  iconColor: Colors.white,
                  backgroundColor: Colors.blue[200],
                  radius: 100,
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitialPage());
                  },
                ),
                SizedBox(width: 30),
                RoundedButton(
                  icon: Icons.home,
                  iconColor: Colors.white,
                  backgroundColor: Colors.blue[200],
                  radius: 100,
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitialPage());
                  },
                ),
                RoundedButton(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: Colors.blue[200],
                  radius: 100,
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitialPage());
                  },
                ),
              ],
            ),
          ),
          Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 2, color: Colors.blueAccent),
                )),
              )),
          Positioned(
              top: 120,
              left: 20,
              right: 20,
              bottom: 0,
              child: Container(
                child: GetBuilder<CartController>(builder: (cartController) {
                  return ListView.builder(
                      itemCount: cartController.getCartItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          height: 200,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Food Image
                              GestureDetector(
                                onTap: () {
                                  var popularPageIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(cartController
                                              .getCartItems[index]
                                              .productsModel);
                                  var recommendedPageIndex =
                                      Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(cartController
                                              .getCartItems[index]
                                              .productsModel);
                                  if (popularPageIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFoodPage(
                                        popularPageIndex, 'cartPage'));
                                  } else {
                                    Get.toNamed(
                                        RouteHelper.getRecommendedFoodPage(
                                            recommendedPageIndex, 'cartPage'));
                                  }
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            AppContants.appBaseURI +
                                                '/uploads/' +
                                                cartController
                                                    .getCartItems[index].img!),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                        text: cartController
                                            .getCartItems[index].name!,
                                        color: Colors.black87),
                                    SizedBox(height: 15),
                                    SmallText(text: 'Spicy'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                            text:
                                                '\$ ${cartController.getCartItems[index].price!}',
                                            color: Colors.redAccent),
                                        RoundedButton(
                                          onTap: () {},
                                          backgroundColor: Colors.white,
                                          width: 120,
                                          height: 60,
                                          radius: 20,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomIconButton(
                                                icon: Icons.remove,
                                                iconSize: 28,
                                                onTap: () {
                                                  cartController.addItems(
                                                      cartController
                                                          .getCartItems[index]
                                                          .productsModel!,
                                                      -1);
                                                },
                                              ),
                                              BigText(
                                                text: cartController
                                                    .getCartItems[index]
                                                    .quantity
                                                    .toString(),
                                                color: Colors.black87,
                                                size: 22,
                                              ),
                                              CustomIconButton(
                                                icon: Icons.add,
                                                iconSize: 28,
                                                onTap: () {
                                                  cartController.addItems(
                                                      cartController
                                                          .getCartItems[index]
                                                          .productsModel!,
                                                      1);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
              )),
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: GetBuilder<CartController>(builder: (cartController) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundedButton(
                onTap: () {},
                backgroundColor: Colors.white,
                width: 120,
                height: 60,
                radius: 20,
                child: Center(
                  child: BigText(
                    text: '\$ ${cartController.totalAmount}',
                    color: Colors.black87,
                  ),
                ),
              ),
              RoundedButton(
                onTap: () {
                  print('It\' working properly');
                  cartController.addToHistory();
                },
                backgroundColor: Colors.blue[200],
                width: 160,
                height: 60,
                radius: 20,
                child: Center(
                  child: BigText(
                    text: 'Check out',
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
