import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop01_app/models/home_model.dart';
import 'package:shop01_app/models/setting_screen/setting_screen.dart';
import 'package:shop01_app/modules/categries_screen/categries_screen.dart';
import 'package:shop01_app/modules/favorites_screen/favorites.dart';
import 'package:shop01_app/modules/products_screen/products_screen.dart';
import 'package:shop01_app/shared/cubit/shop_state.dart';
import 'package:shop01_app/shared/network/components/constatnts.dart';
import 'package:shop01_app/shared/network/end_points.dart';
import 'package:shop01_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [Products(), Categries(), Favorites(), Setting()];
  void changBottomNav(int index) {
    currentIndex = index;
    emit(ShopBotttomNavState());
  }

  HomeModel? homeModel;
  void getDataHome() {
    emit(ShopLoadingHomeData());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      print(homeModel!.status);
      print(homeModel!.data);
      // print(value.data);
      print(homeModel?.data!.banners[0].id);
      emit(ShopSuccessHomedataState());
    }).catchError((error) {
      print('theeee errror:${error.toString()}');
      emit(ShopErrorHomedataState());
    });
  }
}
