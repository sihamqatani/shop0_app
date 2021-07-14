class HomeModel {
  bool? status;

  HomeDataModel? data;

  /* factory HomeModel.fromjson(Map<String, dynamic> json) {
    return HomeModel(
        status: json['status'], data: HomeDataModel.fromjson(json['data']));
  }*/
  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      // banners.add(element);
      banners.add(BannerModel.fromjson(element));
    });
    json['products'].forEach((element) {
      //products.add(element);
      products.add(ProductModel.fromjson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;
  late bool favorite;
  bool? cart;
  ProductModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    favorite = json['in_favorites'];
    cart = json['in_cart'];
  }
}
