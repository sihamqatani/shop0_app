import 'package:shop01_app/models/favorite_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopBotttomNavState extends ShopStates {}

class ShopSuccessHomedataState extends ShopStates {}

//class ShopLoadingHomeData extends ShopStates {}

class ShopErrorHomedataState extends ShopStates {}

class ShopLoadingHomedataState extends ShopStates {}

class ShopLoadingCategoriesData extends ShopStates {}

class ShopErrorCategoriesdataState extends ShopStates {}

class ShopSuccessCategoriesdataState extends ShopStates {}

class ShopUserModelData extends ShopStates {}

class ShopErrorUserModeldataState extends ShopStates {}

class ShopSuccessUserModeldataState extends ShopStates {}

class ShopErrorFavoritesdataState extends ShopStates {}

class ShopSuccessFavoritesdataState extends ShopStates {}

class ShopErrorChangeFavoritesdataState extends ShopStates {}

class ShopChangeFavoritesdataState extends ShopStates {}

class ShopLoadingFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesdataState extends ShopStates {
  final FavoritesModel? model;
  ShopSuccessChangeFavoritesdataState(this.model);
}
