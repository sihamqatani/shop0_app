import 'package:shop01_app/models/shop_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopUserModel shopUserModel;

  ShopRegisterSuccessState(this.shopUserModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState({
    required this.error,
  });
}

class ShopRegisterPasswordVisibilitysState extends ShopRegisterStates {}
