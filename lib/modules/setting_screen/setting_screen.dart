import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Setting Screen',
            style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
