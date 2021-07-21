import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop01_app/models/categories.dart';
import 'package:shop01_app/models/favorite_data_model.dart';
import 'package:shop01_app/models/favorite_model.dart';
import 'package:shop01_app/models/home_model.dart';
import 'package:shop01_app/models/shop_model.dart';

import 'package:shop01_app/modules/categries_screen/categries_screen.dart';
import 'package:shop01_app/modules/favorites_screen/favorites.dart';
import 'package:shop01_app/modules/products_screen/products_screen.dart';
import 'package:shop01_app/modules/setting_screen/setting_screen.dart';
import 'package:shop01_app/shared/cubit/shop_state.dart';
import 'package:shop01_app/shared/network/components/constatnts.dart';
import 'package:shop01_app/shared/network/end_points.dart';
import 'package:shop01_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  HomeModel? homeModel;
  late Map<int, bool> favorites = {};
  CatogriesModel? catogriesModel;
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [Products(), Categries(), Favorites(), Setting()];
  void changBottomNav(int index) {
    currentIndex = index;
    emit(ShopBotttomNavState());
  }

  // HomeModel? homeModel;
  void getDataHome() {
    emit(ShopLoadingHomedataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      print(homeModel!.status);
      print(homeModel!.data);
      // print(value.data);
      print(homeModel?.data!.banners[0].id);
      homeModel?.data?.products.forEach((element) {
        favorites.addAll({element.id: element.favorite});
      });
      print('Fovurites is ${favorites.toString()}');
      // ShopSuccessHomedataState();
      emit(ShopSuccessHomedataState());
    }).catchError((error) {
      print('theeee errror:${error.toString()}');
      emit(ShopErrorHomedataState());
    });
  }

  FavoritesModel? favoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesdataState());

    DioHelper.postData(
            url: FAVORITE, data: {'product_id': productId}, token: token)
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value?.data);
      print('favo model${value?.data.toString()}');
      print(' the headers is ::${DioHelper.dio?.options.headers}');
      if (!favoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else
        getDatFavorites();
      emit(ShopSuccessChangeFavoritesdataState(favoritesModel));
    }).catchError((onError) {
      print('error favo is.....${onError.toString()}');
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesdataState());
    });
  }

  void getDatCateogries() {
    DioHelper.getData(url: GET_CATOGRIES, token: token).then((value) {
      catogriesModel = CatogriesModel.fromjson(value.data);
      print(' Catogries status is : ${catogriesModel?.status}');
      // print(value.data);

      emit(ShopSuccessCategoriesdataState());
    }).catchError((error) {
      print('theeee errror Catogry:${error.toString()}');
      emit(ShopErrorCategoriesdataState());
    });
  }

  FavoriteDataModel? favoriteDataModel;
  void getDatFavorites() {
    emit(ShopLoadingFavoritesState());

    DioHelper.getData(url: FAVORITE, token: token).then((value) {
      favoriteDataModel = FavoriteDataModel.fromJson(value.data);
      print(' Favorites status is : ${favoriteDataModel?.status}');
      // print(value.data);

      emit(ShopSuccessFavoritesdataState());
    }).catchError((error) {
      print('theeee errror favorites:${error.toString()}');
      emit(ShopErrorFavoritesdataState());
    });
  }

  ShopUserModel? shopUserModel;
  void getUserModel() {
    emit(ShopLoadingFavoritesState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      shopUserModel = ShopUserModel.fromjson(value.data);
      print(' USER NAME::>>> : ${shopUserModel?.data?.name}');
      // print(value.data);

      emit(ShopSuccessUserModeldataState());
    }).catchError((error) {
      print('theeee errror in UserModel is :::${error.toString()}');
      emit(ShopErrorUserModeldataState());
    });
  }
}
