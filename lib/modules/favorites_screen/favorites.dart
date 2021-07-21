import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop01_app/models/favorite_data_model.dart';
import 'package:shop01_app/shared/colors.dart';
import 'package:shop01_app/shared/cubit/shop_cubit.dart';
import 'package:shop01_app/shared/cubit/shop_state.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) =>
                  state is! ShopLoadingFavoritesState,
              widgetBuilder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildFavItem(
                      ShopCubit.get(context)
                          .favoriteDataModel
                          ?.data
                          ?.data[index],
                      context),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        color: Colors.grey[300],
                        height: 1,
                      ),
                  itemCount: ShopCubit.get(context)
                      .favoriteDataModel!
                      .data!
                      .data
                      .length),
              fallbackBuilder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  Widget buildFavItem(FavoritesData? data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              child:
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  image: NetworkImage(
                    data!.product!.image,
                  ),
                  // 'https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg'),
                  width: double.infinity,
                  height: 120,

                  // fit: BoxFit.cover,
                ),
                if (data.product?.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Text(
                      'DICOUNT',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
              ]),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.product!.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(height: 1.4, fontSize: 14),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        data.product!.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                        style: TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (data.product?.discount != 0)
                        Text(
                          '${data.product!.oldPrice.toString()}',
                          overflow: TextOverflow.ellipsis,
                          // maxLines: 2,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(data.product!.id);
                          //print('');
                        },
                        icon: CircleAvatar(
                            radius: 14.0,
                            // ignore: dead_code
                            backgroundColor: ShopCubit.get(context)
                                    .favorites[data.product?.id]!
                                ? defaultColor
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )),
                        iconSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
