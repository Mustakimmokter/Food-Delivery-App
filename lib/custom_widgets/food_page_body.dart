import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/app_contants.dart';
import 'package:food_delivery_app_one/controller/popular_product_controller.dart';
import 'package:food_delivery_app_one/controller/recommended_products_controller.dart';
import 'package:food_delivery_app_one/custom_widgets/big_text.dart';
import 'package:food_delivery_app_one/custom_widgets/small_text.dart';
import 'package:food_delivery_app_one/custom_widgets/text_&_icon_widget.dart';
import 'package:food_delivery_app_one/products_model/products_model.dart';
import 'package:food_delivery_app_one/route_helper/route_helper.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController _pageController = PageController(viewportFraction: 0.90);
  double _currentPageValue = 0.0;
  double _scaleFactor = 0.80;
  double _height = 220;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Popular Food //
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoading
              ? Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 320,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, index) => _pageBuilder(
                        index, popularProducts.popularProductList[index]),
                  ),
                )
              : CircularProgressIndicator(
                  color: Colors.blue[300],
                );
        }),

        /// Dot indicator //
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: 30),

        /// Recommended Text //
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: const [
              BigText(
                text: 'Recommended',
                color: Colors.black87,
                size: 18,
              ),
              SizedBox(width: 10),
              BigText(text: '.', color: Colors.black54),
              SizedBox(width: 10),
              SmallText(text: 'Food Pairing'),
            ],
          ),
        ),

        /// Recommended food //
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isLoading
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProducts.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFoodPage(
                            index, 'recommendedFoodPage'));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(AppContants.appBaseURI +
                                        '/uploads/' +
                                        recommendedProducts
                                            .recommendedProductList[index]
                                            .img!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                height: 90,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                        text: recommendedProducts
                                            .recommendedProductList[index]
                                            .name!,
                                        size: 18,
                                        color: Colors.black87),
                                    SmallText(
                                        text: recommendedProducts
                                            .recommendedProductList[index]
                                            .description!),
                                    Row(
                                      children: [
                                        TextAndIconWidget(
                                            text: 'Normal',
                                            icon: Icons.circle_sharp,
                                            iconSize: 18,
                                            iconColor: Colors.deepOrange[400]),
                                        SizedBox(width: 04),
                                        TextAndIconWidget(
                                            text: '1.7km',
                                            icon: Icons.location_on_rounded,
                                            iconSize: 18,
                                            iconColor: Colors.blue[300]),
                                        SizedBox(width: 04),
                                        TextAndIconWidget(
                                            text: '21min',
                                            icon: Icons.access_time,
                                            iconSize: 18,
                                            iconColor: Colors.red),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: Colors.blue[300],
                );
        }),
      ],
    );
  }

  /// Page Builder Function //
  Widget _pageBuilder(int index, ProductsModel productsModel) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - currentScale) / 2, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - currentScale) / 2, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - currentScale) / 2, 0);
    } else {
      var currentSale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentSale, 1)
        ..setTranslationRaw(0, _height * (1 - currentSale) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          /// Popular Food //
          GetBuilder<PopularProductController>(builder: (popularProducts) {
            return popularProducts.isLoading
                ? GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getPopularFoodPage(
                          index, 'popularFoodPage'));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 05),
                      height: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(AppContants.appBaseURI +
                                '/uploads/' +
                                productsModel.img!),
                            fit: BoxFit.cover,
                          )),
                      child: popularProducts.isLoading
                          ? null
                          : CircularProgressIndicator(
                              color: Colors.blue[300],
                            ),
                    ),
                  )
                : CircularProgressIndicator(
                    color: Colors.blue,
                  );
          }),

          /// Food review //
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffe8e8e8),
                      offset: Offset(0, 1),
                      blurRadius: 05,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(
                    text: productsModel.name!,
                    color: Colors.black87,
                  ),
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
                        text: productsModel.stars.toString(),
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
          )
        ],
      ),
    );
  }
}
