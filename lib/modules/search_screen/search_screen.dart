import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop01_app/modules/search_screen/cubit/search_cubit.dart';
import 'package:shop01_app/modules/search_screen/cubit/search_states.dart';
import 'package:shop01_app/shared/colors.dart';
import 'package:shop01_app/shared/cubit/shop_cubit.dart';
import 'package:shop01_app/shared/network/components/components.dart';

class Search extends StatelessWidget {
  //const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late var searchController = TextEditingController();
    var fromKey2 = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: fromKey2,
                child: Column(children: [
                  defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) return 'enter text to search';
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      }),
                  SizedBox(height: 20),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(height: 20),
                  if (state is SearchSuccessState)
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) => true,
                      widgetBuilder: (context) => Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildSearchItem(
                                SearchCubit.get(context)
                                    .searchDataModel!
                                    .data!
                                    .data[index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  height: 1,
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchDataModel!
                                .data!
                                .data
                                .length),
                      ),
                      fallbackBuilder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(data, context, {isOldPrice = true}) {
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
                    data.image,
                  ),
                  // 'https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg'),
                  width: double.infinity,
                  height: 120,

                  // fit: BoxFit.cover,
                ),
                if (data.discount != 0 && isOldPrice)
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
                    data.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(height: 1.4, fontSize: 14),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        data.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                        style: TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (data.discount != 0 && isOldPrice)
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
