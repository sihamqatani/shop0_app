import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop01_app/models/shop_model.dart';
import 'package:shop01_app/modules/register/cubit/state.dart';
import 'package:shop01_app/shared/network/end_points.dart';
import 'package:shop01_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late ShopUserModel shopUserModel;

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone
      },
    ).then((value) {
      shopUserModel = ShopUserModel.fromjson(value?.data);
      // token = shopUserModel.data?.token;
// print(shopUserModel?.data.token);
      //print(shopUserModel.status);

      // print(' the data is: ${value?.data.toString()}');

      emit(ShopRegisterSuccessState(shopUserModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error: error.toString()));
      print(' the error is :${error.toString()}');
    });
  }

  IconData iconVisiblity = Icons.visibility;
  bool isPasword = true;
  void changPasswordVisibilty() {
    isPasword = !isPasword;
    iconVisiblity =
        isPasword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ShopRegisterPasswordVisibilitysState());
  }
}
