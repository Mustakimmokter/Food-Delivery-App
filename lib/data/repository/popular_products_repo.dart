import 'package:food_delivery_app_one/app_contants.dart';
import 'package:food_delivery_app_one/data/api_clients/api_client.dart';
import 'package:get/get.dart';

class PopularProductsRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductsRepo({required this.apiClient});

  Future<Response> getPopularProductsList() async {
    return await apiClient.getData(AppContants.popularProductsURI);
  }
}
