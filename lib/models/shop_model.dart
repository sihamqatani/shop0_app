class ShopUserModel {
  late  bool status;
    late  String  message;
   LoginUserData? data;
 
  ShopUserModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=(json['data']!=null?LoginUserData.fromjson(json['data']):null);

  }

}
class LoginUserData {
  int ?id;
  String ?name;
  String ?email;
  String ?phone;
  String ?image;
  int ? points;
  int ? credit;
  String ? token;
  LoginUserData({
     this.id,
   this.name,
     this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });
  LoginUserData.fromjson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token= json['token'];
  }



}
