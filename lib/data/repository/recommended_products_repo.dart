import 'package:food_delivery_app_one/app_contants.dart';
import 'package:food_delivery_app_one/data/api_clients/api_client.dart';
import 'package:get/get.dart';

class RecommendedProductsRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductsRepo({required this.apiClient});

  Future<Response> getRecommendedProductsList() async {
    return await apiClient.getData(AppContants.recommendedProductsURI);
  }
}
