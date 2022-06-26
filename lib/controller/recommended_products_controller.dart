import 'package:food_delivery_app_one/data/repository/recommended_products_repo.dart';
import 'package:food_delivery_app_one/products_model/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductsRepo recommendedProductsRepo;
  RecommendedProductController({required this.recommendedProductsRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductsRepo.getRecommendedProductsList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(Products.fromJson(response.body).productsModel);
      update();
      _isLoading = true;
    } else {}
  }
}
