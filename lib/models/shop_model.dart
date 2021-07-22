class ShopUserModel {
  final bool status;
  String? message;
  LoginUserData? data;
  ShopUserModel(this.status, this.message, this.data);

  factory ShopUserModel.fromjson(Map<String, dynamic> json) {
    return ShopUserModel(json['status'], json['message'],
        (json['data'] != null ? LoginUserData.fromjson(json['data']) : null));
  }
}

class LoginUserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  LoginUserData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
