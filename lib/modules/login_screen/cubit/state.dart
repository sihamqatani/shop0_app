import 'package:shop01_app/models/shop_model.dart';

abstract class ShopLoginState {}

class ShopLoginloadingState extends ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final ShopUserModel shopUserModel;

  ShopLoginSuccessState(this.shopUserModel);
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;
  ShopLoginErrorState({
    required this.error,
  });
}

class ShopLoginPasswordVisibilitysState extends ShopLoginState {}
