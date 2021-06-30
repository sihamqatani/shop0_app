import 'package:flutter/material.dart';
import 'package:shop01_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop01_app/shared/colors.dart';
import 'package:shop01_app/shared/components.dart';
import 'package:shop01_app/shared/network/local/cash_helper.dart';
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class OnBoardingModel {
  final String? image;
  final String? title;
  final String? body;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController = PageController();
  bool isLast = false;

  List<OnBoardingModel> boarding = [
    OnBoardingModel(
        image: 'assets/images/shop1.png',
        title: ' board 1',
        body: 'body board 1'),
    OnBoardingModel(
        image: 'assets/images/shop2.png',
        title: ' board 2',
        body: 'body board 2'),
    OnBoardingModel(
        image: 'assets/images/shop3.png',
        title: 'board 3',
        body: 'body board 3')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  CashHelper.saveData(key: 'onBoarding', value: true);
                  navigateAndFinish(context, ShopLoginScreen());
                },
                child: Text('SKIP'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                      print('last');
                    } else {
                      print('not last');
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  itemBuilder: (BuildContext context, int index) {
                    return buildOnboardingItems(boarding[index]);
                  },
                  itemCount: boarding.length,
                ),
              ),
              //SizedBox(height: 30)
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5,
                        expansionFactor: 4,
                        activeDotColor: defaultColor),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        CashHelper.saveData(key: 'onBoarding', value: true);
                        navigateAndFinish(context, ShopLoginScreen());
                      } else {
                        boardController.nextPage(
                            duration: Duration(microseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios_outlined),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildOnboardingItems(OnBoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
