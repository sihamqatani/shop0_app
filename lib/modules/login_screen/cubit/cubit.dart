import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop01_app/models/shop_model.dart';
import 'package:shop01_app/modules/login_screen/cubit/state.dart';
import 'package:shop01_app/shared/network/end_points.dart';
import 'package:shop01_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopUserModel? shopUserModel;
  
  void userLogin({required String email, required String password}) {
    emit(ShopLoginloadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password},)
        .then((value)
 {shopUserModel=ShopUserModel.fromjson(value?.data);
 print(shopUserModel?.data?.token);
 print(shopUserModel!.status);

      print( ' the data is: ${value?.data.toString()}');

      emit(ShopLoginSuccessState(shopUserModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error: error.toString()));
      print(' the error is :${error.toString()}');
    });
  }
  IconData iconVisiblity= Icons.visibility;
  bool isPasword=true;
  void changPasswordVisibilty(){
    isPasword=!isPasword;
    iconVisiblity=isPasword?Icons.visibility_off_outlined:Icons.visibility;
   emit(ShopLoginPasswordVisibilitysState());
  }
}
