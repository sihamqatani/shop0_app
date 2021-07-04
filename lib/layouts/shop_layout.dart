import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop01_app/modules/search_screen/search_screen.dart';
import 'package:shop01_app/shared/cubit/shop_cubit.dart';
import 'package:shop01_app/shared/cubit/shop_state.dart';
import 'package:shop01_app/shared/network/components/components.dart';

class ShopLayout extends StatelessWidget {
  //const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context, Search());
                      },
                      icon: Icon(Icons.search))
                ],
                title: Text('Salla'),
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  index = cubit.currentIndex;
                },
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps_outlined), label: 'Catgories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorites'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ],
              ));
        });
  }
}
