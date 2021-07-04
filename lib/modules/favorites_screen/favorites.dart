import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Favorites Screen',
            style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
