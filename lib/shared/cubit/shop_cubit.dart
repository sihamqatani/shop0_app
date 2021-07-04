import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop01_app/models/setting_screen/setting_screen.dart';
import 'package:shop01_app/modules/categries_screen/categries_screen.dart';
import 'package:shop01_app/modules/favorites_screen/favorites.dart';
import 'package:shop01_app/modules/products_screen/products_screen.dart';
import 'package:shop01_app/shared/cubit/shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [Products(), Categries(), Favorites(), Setting()];
  void changBottomNav(int index) {
    currentIndex = index;
    emit(ShopBotttomNavState());
  }
}
