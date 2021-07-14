class FavoritesModel {
  late bool status;
  String? message;
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
