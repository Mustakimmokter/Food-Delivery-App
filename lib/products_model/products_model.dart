class Products {
  int? _totalSize, _offset, _typeId;
  late List<ProductsModel> _productsModel;
  List<ProductsModel> get productsModel => _productsModel;
  Products(
      {required totalSize,
      required typeId,
      required offset,
      required productsModel}) {
    _totalSize = totalSize;
    _offset = offset;
    _typeId = typeId;
    _productsModel = productsModel;
  }

  Products.fromJson(Map<String, dynamic> json) {
    _typeId = json['type_id'];
    _offset = json['offset'];
    _totalSize = json['total_size'];
    if (json['products'] != null) {
      _productsModel = <ProductsModel>[];
      json['products'].forEach((v) {
        _productsModel.add(ProductsModel.fromJson(v));
      });
    }
  }
}

class ProductsModel {
  int? id, price, stars, typeId;
  String? name, description, img, location, createdAt, updatedAt;
  ProductsModel(
      {required id,
      required price,
      required stars,
      required typeId,
      required name,
      required description,
      required img,
      required location,
      required createdAt,
      required updatedAt});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    stars = json['stars'];
    typeId = json['type_id'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'stars': stars,
      'typeId': typeId,
      'name': name,
      'img': img,
      'location': location,
      'createAt': createdAt,
      'updateAt': updatedAt
    };
  }
}
