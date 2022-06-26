import 'package:food_delivery_app_one/products_model/products_model.dart';

class CartModel {
  int? id, price, quantity;
  String? name, img, time;
  bool? isExist;
  ProductsModel? productsModel;
  CartModel(
      {this.id,
      this.price,
      this.name,
      this.img,
      this.isExist,
      this.quantity,
      this.time,
      this.productsModel});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    img = json['img'];
    quantity = json['Quantity'];
    isExist = json['isExist'];
    time = json['time'];
    productsModel = ProductsModel.fromJson(json['productsModel']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'name': name,
      'img': img,
      'quantity': quantity,
      'isExist': isExist,
      'time': time,
      'productsModel': productsModel!.toJson()
    };
  }
}
