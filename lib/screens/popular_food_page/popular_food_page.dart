import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/app_contants.dart';
import 'package:food_delivery_app_one/controller/cart_controller.dart';
import 'package:food_delivery_app_one/controller/popular_product_controller.dart';
import 'package:food_delivery_app_one/custom_widgets/custom_icon_button.dart';
import 'package:food_delivery_app_one/route_helper/route_helper.dart';
import 'package:get/get.dart';

import '../../custom_widgets/big_text.dart';
import '../../custom_widgets/expanded_widget.dart';
import '../../custom_widgets/rounded_button.dart';
import '../../custom_widgets/small_text.dart';
import '../../custom_widgets/text_&_icon_widget.dart';

class PopularFoodPage extends StatelessWidget {
  final int pageId;
  final String? page;
  const PopularFoodPage({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var popularProducts =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProducts(popularProducts!, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// Food image //
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  image: DecorationImage(
                    image: NetworkImage(AppContants.appBaseURI +
                        '/uploads/' +
                        popularProducts.img!),
                    fit: BoxFit.cover,
                  )),
            ),
          ),

          /// Cancel button and cart button
          Positioned(
            right: 20,
            left: 20,
            top: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Back button
                RoundedButton(
                  icon: Icons.arrow_back,
                  backgroundColor: Colors.grey[200],
                  radius: 100,
                  onTap: () {
                    if (page == 'cartPage') {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitialPage());
                    }
                  },
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

          /// Radius Container //
          Positioned(
            right: 0,
            left: 0,
            top: 240,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food name and Review ///
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: popularProducts.name!,
                          color: Colors.black87,
                        ),
                        SizedBox(height: 14),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(
                                  5,
                                  (index) => Icon(Icons.star,
                                      size: 20, color: Colors.blueGrey)),
                            ),
                            SizedBox(width: 05),
                            SmallText(
                              text: popularProducts.stars!.toString(),
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            SmallText(
                              text: '1240',
                              size: 16,
                            ),
                            SizedBox(width: 05),
                            SmallText(text: 'Comments'),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            TextAndIconWidget(
                                text: 'Normal',
                                icon: Icons.circle_sharp,
                                iconColor: Colors.deepOrange[400]),
                            SizedBox(width: 06),
                            TextAndIconWidget(
                                text: '1.7km',
                                icon: Icons.location_on_rounded,
                                iconColor: Colors.blue[300]),
                            SizedBox(width: 06),
                            TextAndIconWidget(
                                text: '21min',
                                icon: Icons.access_time,
                                iconColor: Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 22),
                  BigText(text: 'Introduce :', color: Colors.black87),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandedTextWidget(
                          text: popularProducts.description!),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
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
            children: [
              RoundedButton(
                onTap: () {},
                backgroundColor: Colors.white,
                width: 120,
                height: 60,
                radius: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                      icon: Icons.remove,
                      iconSize: 28,
                      onTap: () {
                        popularProduct.getItem(false);
                      },
                    ),
                    BigText(
                      text: popularProduct.inCartItems.toString(),
                      color: Colors.black87,
                      size: 22,
                    ),
                    CustomIconButton(
                      icon: Icons.add,
                      iconSize: 28,
                      onTap: () {
                        popularProduct.getItem(true);
                      },
                    ),
                  ],
                ),
              ),
              RoundedButton(
                onTap: () {
                  popularProduct.addItems(popularProducts);
                },
                backgroundColor: Colors.blue[200],
                width: 200,
                height: 60,
                radius: 20,
                child: Center(
                  child: BigText(
                    text: '\$${popularProducts.price!} Add to cart',
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
