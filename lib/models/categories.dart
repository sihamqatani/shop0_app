class CatogriesModel {
  late bool status;
  DataCtogriesModel? data;
  CatogriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataCtogriesModel.fromjson(json['data']);
  }
}

class DataCtogriesModel {
  late int currentPage;
  List<DataModel> data = [];
  DataCtogriesModel.fromjson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromjson(element));
    });
  }
}

class DataModel {
  int? id;
  late String name;
  late String image;
  DataModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
