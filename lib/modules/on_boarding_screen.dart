import 'package:flutter/material.dart';

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

class OnBoarding extends StatelessWidget {
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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return buildOnboardingItems(boarding[index]);
                  },
                  itemCount: boarding.length,
                ),
              ),
              //SizedBox(height: 30)
              Row(
                children: [
                  Text('Indicator'),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {},
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
