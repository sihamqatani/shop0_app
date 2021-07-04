import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child:
            Text('Search Screen', style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
