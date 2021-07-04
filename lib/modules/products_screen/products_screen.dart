import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Products Screen',
            style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
