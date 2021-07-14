import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop01_app/layouts/shop_layout.dart';
import 'package:shop01_app/modules/login_screen/shop_login_screen.dart';

import 'package:shop01_app/modules/on_boarding_screen.dart';
import 'package:shop01_app/shared/cubit/shop_cubit.dart';
import 'package:shop01_app/shared/network/local/cash_helper.dart';
import 'package:shop01_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding();
  DioHelper.init();
  await CashHelper.init();
  bool? onBoard = CashHelper.getData(key: 'onBoarding');
  // print('the errror in onboard $onBoard');
  String? token = CashHelper.getData(key: 'token');
  print('token::${token.toString()}');
  Widget widget;

  if (onBoard != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else
    widget = OnBoarding();

  runApp(ShopApp(
    startWidget: widget,
  ));

  //));
}

class ShopApp extends StatelessWidget {
  final Widget startWidget;
  // final bool onBoard;
  const ShopApp({
    required this.startWidget,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getDataHome()
        ..getDatCateogries(),
      //..getDataC,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                backwardsCompatibility: false,
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                )),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey),
            textTheme: TextTheme(
                bodyText1: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ))),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: HexColor('333739'),
          primarySwatch: Colors.deepOrange,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepOrange,
          ),
          textTheme: TextTheme(
              bodyText1: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          )),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              backwardsCompatibility: false,
              backgroundColor: HexColor('333739'),
              elevation: 0,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('333739'),
                statusBarIconBrightness: Brightness.light,
              )),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: HexColor('333739'),
              elevation: 20,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey),
        ),
        home: startWidget,
        // onBoard ? ShopLoginScreen() : OnBoarding(),
      ),
    );
  }
}
