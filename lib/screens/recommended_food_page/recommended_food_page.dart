import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/app_contants.dart';
import 'package:food_delivery_app_one/controller/popular_product_controller.dart';
import 'package:food_delivery_app_one/controller/recommended_products_controller.dart';
import 'package:food_delivery_app_one/custom_widgets/big_text.dart';
import 'package:food_delivery_app_one/custom_widgets/rounded_button.dart';
import 'package:food_delivery_app_one/route_helper/route_helper.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../custom_widgets/custom_icon_button.dart';
import '../../custom_widgets/small_text.dart';

class RecommendedFoodPage extends StatelessWidget {
  final int? pageId;
  final String? page;
  const RecommendedFoodPage(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendedProducts = Get.find<RecommendedProductController>()
        .recommendedProductList[pageId!];
    Get.find<PopularProductController>()
        .initProducts(recommendedProducts, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          /// Recommended Food Image & Details
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: Colors.blue[200],
            expandedHeight: 250,
            toolbarHeight: 80,
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Back Button
                  RoundedButton(
                    onTap: () {
                      if (page == 'cartPage') {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitialPage());
                      }
                    },
                    icon: Icons.arrow_back,
                    radius: 100,
                    backgroundColor: Colors.grey[200],
                  ),

                  /// Cart button
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return Stack(
                      children: [
                        RoundedButton(
                          icon: Icons.shopping_cart,
                          backgroundColor: Colors.grey[200],
                          radius: 100,
                          onTap: () {
                            if (controller.totalItems >= 1)
                              Get.toNamed(RouteHelper.getCartPage());
                          },
                        ),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: SmallText(
                                      text: controller.totalItems.toString(),
                                      color: Colors.white,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    );
                  })
                ],
              ),
            ),

            /// Food Image
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppContants.appBaseURI + '/uploads/' + recommendedProducts.img!,
                fit: BoxFit.cover,
              ),
            ),

            /// Food Header name
            bottom: PreferredSize(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Center(
                    child: BigText(
                        text: recommendedProducts.name!,
                        color: Colors.black87)),
              ),
              preferredSize: Size.fromHeight(20),
            ),
          ),

          /// Recommended Food Description
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                recommendedProducts.description!,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Quantity increase and decrease
          GetBuilder<PopularProductController>(builder: (controller) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                    onTap: () {
                      controller.getItem(false);
                    },
                    icon: Icons.remove,
                    iconColor: Colors.white,
                    radius: 100,
                    backgroundColor: Colors.blue[200],
                  ),
                  BigText(
                      text:
                          '\$ ${recommendedProducts.price!} x ${controller.inCartItems}',
                      color: Colors.black87),
                  RoundedButton(
                    onTap: () {
                      controller.getItem(true);
                    },
                    icon: Icons.add,
                    iconColor: Colors.white,
                    radius: 100,
                    backgroundColor: Colors.blue[200],
                  ),
                ],
              ),
            );
          }),

          /// Cart button
          GetBuilder<PopularProductController>(builder: (controller) {
            return Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundedButton(
                    onTap: () {},
                    backgroundColor: Colors.white,
                    width: 60,
                    height: 60,
                    radius: 10,
                    child: CustomIconButton(
                      icon: Icons.favorite,
                      iconColor: Colors.blue[200],
                      iconSize: 28,
                      onTap: () {},
                    ),
                  ),
                  RoundedButton(
                    onTap: () {
                      controller.addItems(recommendedProducts);
                    },
                    backgroundColor: Colors.blue[200],
                    width: 200,
                    height: 60,
                    radius: 20,
                    child: Center(
                      child: BigText(
                        text:
                            '\$ ${recommendedProducts.price! * controller.inCartItems} Add to cart',
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
