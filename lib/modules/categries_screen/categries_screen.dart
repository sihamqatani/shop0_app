import 'package:flutter/material.dart';

class Categries extends StatelessWidget {
  const Categries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Categries Screen',
            style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
