import 'package:food_delivery_app_one/cart_page/cart_page_one.dart';
import 'package:food_delivery_app_one/screens/home_page/home_page.dart';
import 'package:food_delivery_app_one/screens/popular_food_page/popular_food_page.dart';
import 'package:food_delivery_app_one/screens/recommended_food_page/recommended_food_page.dart';
import 'package:food_delivery_app_one/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String _initialPage = '/';
  static const String _splashScreen = '/splash-Screen';
  static const String _popularFoodPage = '/Populer-FoodPage';
  static const String _recommendedFoodPage = '/Recommended-Food-Page';
  static const String _cartPage = '/Cart-page';

  static String getInitialPage() => '$_initialPage';
  static String getSplashScreen() => '$_splashScreen';
  static String getPopularFoodPage(int pageId, String page) =>
      '$_popularFoodPage?pageId=$pageId&page=$page';
  static String getRecommendedFoodPage(int pageId, String page) =>
      '$_recommendedFoodPage?pageId=$pageId&page=$page';
  static String getCartPage() => '$_cartPage';

  static List<GetPage> getRoutes = [
    /// MainFood Page
    GetPage(
        name: _initialPage,
        page: () => HomePage(),
        transition: Transition.fadeIn),

    /// Splash Screen
    GetPage(name: _splashScreen, page: () => SplashScreen()),

    /// Popular Food Page
    GetPage(
        name: _popularFoodPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodPage(pageId: int.parse(pageId!), page: page);
        },
        transition: Transition.fadeIn),

    /// Recommended Food Page
    GetPage(
        name: _recommendedFoodPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodPage(pageId: int.parse(pageId!), page: page);
        },
        transition: Transition.fadeIn),

    /// Cart Page
    GetPage(
      name: _cartPage,
      page: () {
        return CartPageOne();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
