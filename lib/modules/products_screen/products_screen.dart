import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop01_app/models/categories.dart';
import 'package:shop01_app/models/home_model.dart';
import 'package:shop01_app/shared/colors.dart';
import 'package:shop01_app/shared/cubit/shop_cubit.dart';
import 'package:shop01_app/shared/cubit/shop_state.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).catogriesModel != null,
            widgetBuilder: (context) => builderProducts(
                ShopCubit.get(context).homeModel,
                ShopCubit.get(context).catogriesModel,
                context),
            fallbackBuilder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget builderProducts(
      HomeModel? model, CatogriesModel? catogriesModel, BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model?.data?.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 4),
                  reverse: false,
                  viewportFraction: 1.5,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlayCurve: Curves.fastOutSlowIn)),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cateogries',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildCateogriesItem(
                            catogriesModel?.data?.data[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: catogriesModel!.data!.data.length),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('New Products',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.57,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: List.generate(
                  model!.data!.products.length,
                  (index) =>
                      buildGrigProduct(model.data!.products[index], context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCateogriesItem(DataModel? dataModel) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(dataModel!.image),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        Container(
            width: 100,
            //height: 100,
            color: Colors.black.withOpacity(0.5),
            child: Text(
              dataModel.name,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
  }

  Widget buildGrigProduct(ProductModel model, BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 100,

              // fit: BoxFit.cover,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                child: Text(
                  'DICOUNT',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              )
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(height: 1.4, fontSize: 14),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      overflow: TextOverflow.ellipsis,
                      // maxLines: 2,
                      style: TextStyle(fontSize: 12, color: defaultColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
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
                        print(model.id);
                      },
                      icon: CircleAvatar(
                          radius: 14.0,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
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
    );
  }
}
